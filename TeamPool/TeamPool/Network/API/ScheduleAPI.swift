//
//  ScheduleAPI.swift
//  TeamPool
//
//  Created by 성현주 on 6/4/25.
//

import Foundation
import Moya

enum ScheduleAPI {
    case addPoolSchedule(ScheduleCreateRequestDTO)
    case fetchSchedules(poolId: Int)
}

extension ScheduleAPI: BaseTargetType {

    var path: String {
        switch self {
        case .addPoolSchedule, .fetchSchedules:
            return "/api/schedules"
        }
    }

    var method: Moya.Method {
        switch self {
        case .addPoolSchedule:
            return .post
        case .fetchSchedules:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .addPoolSchedule(let dto):
            return .requestJSONEncodable(dto)
        case .fetchSchedules(let poolId):
            return .requestParameters(parameters: ["poolId": poolId], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserDefaultHandler.accessToken)"
        ]
    }
}


final class AddPoolScheduleService {
    private let provider = MoyaProvider<ScheduleAPI>(plugins: [MoyaLoggerPlugin()])

    func addPoolSchedule(
        request: ScheduleCreateRequestDTO,
        completion: @escaping (NetworkResult<Void>) -> Void
    ) {
        provider.request(.addPoolSchedule(request)) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 || response.statusCode == 201 {
                    completion(.success(()))
                } else {
                    print("❌ 일정 추가 실패 상태 코드: \(response.statusCode)")
                    completion(.requestErr("일정 추가에 실패했습니다."))
                }
            case .failure:
                completion(.networkFail)
            }
        }
    }

    func fetchSchedules(poolId: Int, completion: @escaping (NetworkResult<[ScheduleResponseDTO]>) -> Void) {
        provider.request(.fetchSchedules(poolId: poolId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(APIResponse<[ScheduleResponseDTO]>.self, from: response.data)
                    completion(.success(decoded.data))
                } catch {
                    print("❌ 디코딩 실패: \(error)")
                    completion(.pathErr)
                }
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
