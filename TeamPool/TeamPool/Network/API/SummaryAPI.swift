//
//  SummaryAPI.swift
//  TeamPool
//
//  Created by 성현주 on 6/10/25.
//

import Foundation
import Moya

enum SummaryAPI {
    case summarize(content: String)
}

extension SummaryAPI: BaseTargetType {
    var baseURL: URL {
        return URL(string: "https://api.openai.com/v1")!
    }

    var path: String {
        return "/chat/completions"
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .summarize(let content):
            let messages: [OpenAIChatMessage] = [
                .init(role: "system", content: "다음 텍스트가 회의록이라면 핵심 내용을 3~5줄로 한국어로 요약해줘. 의미 없는 말이면 '요약할 내용이 없습니다'라고 답해줘."),
                .init(role: "user", content: content)
            ]
            let request = ChatGPTRequestDTO(
                model: "gpt-3.5-turbo",
                messages: messages,
                temperature: 0.7
            )
            return .requestJSONEncodable(request)
        }
    }

    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(API_KEY)"
        ]
    }
}

final class SummaryService {

    private let provider = MoyaProvider<SummaryAPI>()

    func summarizeWithChatGPT(transcript: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard !transcript.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("⚠️ content가 비어 있어서 요약 요청을 생략합니다.")
            completion(.failure(NSError(domain: "EmptyContent", code: -999, userInfo: [NSLocalizedDescriptionKey: "내용이 비어 있습니다."])))
            return
        }

        print("📤 ChatGPT 요청 내용:\n\(transcript)")

        provider.request(.summarize(content: transcript)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(ChatGPTResponseDTO.self, from: response.data)
                    if let summary = decoded.choices.first?.message.content {
                        completion(.success(summary))
                    } else {
                        completion(.failure(NSError(domain: "No content", code: -1)))
                    }
                } catch {
                    print("❌ 디코딩 오류: \(error)")
                    completion(.failure(error))
                }

            case .failure(let error):
                print("❌ API 요청 실패: \(error)")
                completion(.failure(error))
            }
        }
    }
}

