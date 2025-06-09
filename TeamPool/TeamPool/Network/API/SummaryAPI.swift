//
//  SummaryAPI.swift
//  TeamPool
//
//  Created by 성현주 on 6/10/25.
//

import Foundation
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
                .init(role: "system", content: "다음 회의록 내용을 한국어로 3~5줄 요약해줘."),
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
