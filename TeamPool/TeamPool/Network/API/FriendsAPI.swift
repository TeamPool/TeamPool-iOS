//
//  FriendsAPI.swift
//  TeamPool
//
//  Created by 성현주 on 6/3/25.
//

import Foundation
import Moya

enum FriendsAPI {
    case getFriends
}

extension FriendsAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getFriends:
            return "/api/friends"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserDefaultHandler.accessToken)"
        ]
    }
}

final class FriendsService {
    private let provider = MoyaProvider<FriendsAPI>(plugins: [MoyaLoggerPlugin()])

    func fetchFriends(completion: @escaping (NetworkResult<[FindPeopleModel]>) -> Void) {
        provider.request(.getFriends) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(APIResponse<[FriendDTO]>.self, from: response.data)
                    let models = decoded.data.map { FindPeopleModel(from: $0) }
                    completion(.success(models))
                } catch {
                    print("디코딩 오류:", error)
                    completion(.pathErr)
                }
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
