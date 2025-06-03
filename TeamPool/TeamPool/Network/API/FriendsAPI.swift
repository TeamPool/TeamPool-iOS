//
//  FriendsAPI.swift
//  TeamPool
//
//  Created by 성현주 on 6/3/25.
//
import Moya
import UIKit

enum FriendsAPI {
    case getMyFriends
    case searchFriend(studentNumber: String)
}

extension FriendsAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getMyFriends, .searchFriend:
            return "/api/friends"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMyFriends:
            return .get
        case .searchFriend:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .getMyFriends:
            return .requestPlain
        case .searchFriend(let studentNumber):
            return .requestJSONEncodable(["studentNumber": studentNumber])
        }
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
        provider.request(.getMyFriends) { result in
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

    func searchFriend(by studentNumber: String, completion: @escaping (NetworkResult<[FindPeopleModel]>) -> Void) {
            provider.request(.searchFriend(studentNumber: studentNumber)) { result in
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
