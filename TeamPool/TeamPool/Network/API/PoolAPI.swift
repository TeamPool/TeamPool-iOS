//
//  PoolAPI.swift
//  TeamPool
//
//  Created by 성현주 on 6/4/25.
//

import Foundation
import Moya

enum PoolAPI {
    case createPool(PoolCreateRequestDTO)
}

extension PoolAPI: BaseTargetType {

    var path: String {
        switch self {
        case .createPool:
            return "/api/pools"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .createPool(let dto):
            return .requestJSONEncodable(dto)
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserDefaultHandler.accessToken)"
        ]
    }
}


final class PoolService {
    private let provider = MoyaProvider<PoolAPI>(plugins: [MoyaLoggerPlugin()])

    func createPool(
        with request: PoolCreateRequestDTO,
        completion: @escaping (NetworkResult<Int>) -> Void
    ) {
        provider.request(.createPool(request)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(APIResponse<PoolCreateResponseDTO>.self, from: response.data)
                    completion(.success(decoded.data.poolId))
                } catch {
                    print("❌ 디코딩 실패:", error)
                    completion(.pathErr)
                }

            case .failure:
                completion(.networkFail)
            }
        }
    }
}
