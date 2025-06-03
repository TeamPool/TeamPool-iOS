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
}

extension ScheduleAPI: BaseTargetType {

    var path: String {
        switch self {
        case .addPoolSchedule:
            return "/api/schedules"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .addPoolSchedule(let dto):
            return .requestJSONEncodable(dto)
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
                if response.statusCode == 201 || response.statusCode == 200 {
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
}
