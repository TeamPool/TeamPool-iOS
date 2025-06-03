//
//  CommentsPostAPI.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/18/25.
//

import Foundation
import Moya

enum CommentsPostAPI {
    case postComment(islandId: Int, body: CommentRequest)
}

extension CommentsPostAPI: BaseTargetType {

    var path: String {
        switch self {
        case .postComment(let islandId, _):
            return "/islands/\(islandId)/comments"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postComment:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .postComment(_, let body):
            return .requestJSONEncodable(body)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

final class CommentsPostService {

    private let provider = MoyaProvider<CommentsPostAPI>(plugins: [MoyaLoggerPlugin()])

    func postComment(to islandId: Int, content: String, completion: @escaping (NetworkResult<String>) -> Void) {
        let requestBody = CommentRequest(comment: content)

        provider.request(.postComment(islandId: islandId, body: requestBody)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(CommentPostResponse.self, from: response.data)
                } catch {
                    print("디코딩 에러:", error)
                    completion(.pathErr)
                }

            case .failure:
                completion(.networkFail)
            }
        }
    }
}

