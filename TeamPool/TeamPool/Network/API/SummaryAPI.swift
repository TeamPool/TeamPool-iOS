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
                .init(role: "system", content: """
                다음 텍스트는 말로 진행된 회의의 STT(음성 인식) 결과입니다. 문장 구분이 없고 어색할 수 있지만, 핵심 내용을 3~5줄로 한국어로 요약해줘.

                - 가능한 한 명확한 항목으로 정리해줘.
                - 업무 분담 내용이 있다면 사람 이름과 함께 요약해줘.
                - 내용이 너무 불분명하거나 회의록이 아니면 '요약할 내용이 없습니다'라고 해줘.
                """),
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

