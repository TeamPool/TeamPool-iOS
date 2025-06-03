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
    case addFriends(studentNumber: String)
    case deleteFriend(friendUserId: Int)
    case searchFriend(studentNumber: String)
}

extension FriendsAPI: BaseTargetType {
    var path: String {
        switch self {
        case .getMyFriends, .addFriends:
            return "/api/friends"
        case .deleteFriend(let friendUserId):
            return "/api/friends/\(friendUserId)"
        case .searchFriend:
            return "/api/friends/search"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMyFriends:
            return .get
        case .addFriends, .searchFriend:
            return .post
        case .deleteFriend:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case .getMyFriends, .deleteFriend:
            return .requestPlain
        case .addFriends(let studentNumber), .searchFriend(let studentNumber):
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

    func addFriends(by studentNumber: String, completion: @escaping (NetworkResult<[FindPeopleModel]>) -> Void) {
        provider.request(.addFriends(studentNumber: studentNumber)) { result in
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

    func deleteFriend(friendUserId: Int, completion: @escaping (NetworkResult<Void>) -> Void) {
        provider.request(.deleteFriend(friendUserId: friendUserId)) { result in
            switch result {
            case .success(let response):
                if (200..<300).contains(response.statusCode) {
                    completion(.success(()))
                } else {
                    do {
                        let error = try JSONDecoder().decode(APIResponse<String>.self, from: response.data)
                        completion(.requestErr(error.message))
                    } catch {
                        completion(.requestErr("삭제 실패: 알 수 없는 오류"))
                    }
                }

            case .failure:
                completion(.networkFail)
            }
        }
    }

    func searchFriend(by studentNumber: String, completion: @escaping (NetworkResult<FindPeopleModel>) -> Void) {
        provider.request(.searchFriend(studentNumber: studentNumber)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(APIResponse<SearchFriendDTO>.self, from: response.data)
                    let model = FindPeopleModel(friendId: nil, nickname: decoded.data.nickname, studentNumber: decoded.data.studentNumber)
                    completion(.success(model))
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
