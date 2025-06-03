//
//  MyPageAPI.swift
//  TeamPool
//
//  Created by 성현주 on 6/3/25.
//

import Foundation
import Moya

enum MyPageAPI {
    case updateNickname(nickname: String)
    case deleteUser
}

extension MyPageAPI: BaseTargetType {

    var path: String {
        switch self {
        case .updateNickname:
            return "/api/users/nickname"
        case .deleteUser:
            return "/api/users/me"
        }
    }

    var method: Moya.Method {
        switch self {
        case .updateNickname:
            return .post
        case .deleteUser:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case .updateNickname(let nickname):
            return .requestParameters(parameters: ["nickname": nickname], encoding: JSONEncoding.default)
        case .deleteUser:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserDefaultHandler.accessToken)"
        ]
    }
}

final class MyPageService {

    private let provider = MoyaProvider<MyPageAPI>(plugins: [MoyaLoggerPlugin()])

    func updateNickname(_ nickname: String, completion: @escaping (NetworkResult<Void>) -> Void) {
        provider.request(.updateNickname(nickname: nickname)) { result in
            self.handleBasicResponse(result: result, completion: completion)
        }
    }

    func deleteUser(completion: @escaping (NetworkResult<Void>) -> Void) {
        provider.request(.deleteUser) { result in
            self.handleBasicResponse(result: result, completion: completion)
        }
    }

    private func handleBasicResponse(result: Result<Response, MoyaError>, completion: @escaping (NetworkResult<Void>) -> Void) {
        switch result {
        case .success(let response):
            switch response.statusCode {
            case 200..<300:
                completion(.success(()))
            case 400..<500:
                if let error = try? JSONDecoder().decode(ErrorResponseDTO.self, from: response.data) {
                    completion(.requestErr(error.message))
                } else {
                    completion(.requestErr("요청 오류"))
                }
            case 500..<600:
                completion(.serverErr)
            default:
                completion(.networkFail)
            }
        case .failure:
            completion(.networkFail)
        }
    }
}
