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
    case getMyPools
    case getPoolTimetables(poolId: Int)
}

extension PoolAPI: BaseTargetType {

    var path: String {
        switch self {
        case .createPool:
            return "/api/pools"
        case .getMyPools:
            return "/api/pools/my"
        case .getPoolTimetables(let poolId):
            return "/api/pools/\(poolId)/timetables"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createPool:
            return .post
        case .getMyPools, .getPoolTimetables:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .createPool(let dto):
            return .requestJSONEncodable(dto)
        case .getMyPools, .getPoolTimetables:
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


final class PoolService {
    private let provider = MoyaProvider<PoolAPI>(plugins: [MoyaLoggerPlugin()])

    // 기존 생성 API
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

    func fetchMyPools(completion: @escaping (NetworkResult<[MyPoolListResponseDTO]>) -> Void) {
        provider.request(.getMyPools) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(APIResponse<[MyPoolListResponseDTO]>.self, from: response.data)
                    completion(.success(decoded.data))
                } catch {
                    print("❌ 디코딩 실패:", error)
                    completion(.pathErr)
                }

            case .failure:
                completion(.networkFail)
            }
        }
        
    }
    func fetchPoolTimetables(poolId: Int, completion: @escaping (NetworkResult<[PoolTimetableResponseDTO]>) -> Void) {
            provider.request(.getPoolTimetables(poolId: poolId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(APIResponse<[PoolTimetableResponseDTO]>.self, from: response.data)
                        completion(.success(decoded.data))
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
