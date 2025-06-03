//
//  CommentsAPI.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/18/25.
//

import Foundation
import Moya

enum CommentsAPI {
    case getIslandComments(islandId: Int)
    case postIslandComment(islandId: Int, comment: PostCommentRequest)
}

extension CommentsAPI: BaseTargetType {

    var path: String {
        switch self {
        case .getIslandComments(let islandId):
            return "/islands/comments/\(islandId)"
        case .postIslandComment(let islandId, _):
            return "/islands/\(islandId)/comments"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getIslandComments:
            return .get
        case .postIslandComment:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .getIslandComments:
            return .requestPlain
        case .postIslandComment(_, let comment):
            return .requestJSONEncodable(comment)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}


// MARK: - Service

final class CommentsService {

    private let provider = MoyaProvider<CommentsAPI>(plugins: [MoyaLoggerPlugin()])

    func postComment(islandId: Int, request: PostCommentRequest, completion: @escaping (NetworkResult<Void>) -> Void) {
        provider.request(.postIslandComment(islandId: islandId, comment: request)) { result in
            switch result {
            case .success(let response):
                if (200..<300).contains(response.statusCode) {
                    completion(.success(()))  // 응답 바디 없음
                } else {
//                    completion(.requestErr)
                }
            case .failure:
                completion(.networkFail)
            }
        }
    }

    func fetchComments(for islandId: Int, completion: @escaping (NetworkResult<[IslandComment]>) -> Void) {
        provider.request(.getIslandComments(islandId: islandId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(IslandCommentResponse.self, from: response.data)
                    completion(.success(decoded.data))
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

