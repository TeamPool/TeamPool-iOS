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
}

extension MyPageAPI: BaseTargetType {

    var path: String {
        switch self {
        case .updateNickname:
            return "/api/users/nickname"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .updateNickname(let nickname):
            let body: [String: String] = ["nickname": nickname]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
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
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200..<300:
                    completion(.success(()))
                case 400..<500:
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponseDTO.self, from: response.data) {
                        completion(.requestErr(errorResponse.message))
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
}
