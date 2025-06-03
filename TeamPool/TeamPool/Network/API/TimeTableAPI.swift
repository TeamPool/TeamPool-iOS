//
//  TimeTableAPI.swift
//  TeamPool
//
//  Created by 성현주 on 6/4/25.
//

import Foundation
import Moya

enum TimeTableAPI {
    case postTimeTables([TimeTableRequestDTO])
}

extension TimeTableAPI: BaseTargetType {
    var path: String {
        switch self {
        case .postTimeTables:
            return "/api/timetables/me"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .postTimeTables(let timeTables):
            return .requestJSONEncodable(timeTables)
        }
    }

    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(UserDefaultHandler.accessToken)"
        ]
    }
}

import Moya

final class TimeTableService {
    private let provider = MoyaProvider<TimeTableAPI>(plugins: [MoyaLoggerPlugin()])

    func postTimeTables(_ tables: [TimeTableRequestDTO], completion: @escaping (NetworkResult<Void>) -> Void) {
        provider.request(.postTimeTables(tables)) { result in
            switch result {
            case .success(let response):
                if (200..<300).contains(response.statusCode) {
                    completion(.success(()))
                } else {
                    do {
                        let decoded = try JSONDecoder().decode(APIResponse<String>.self, from: response.data)
                        completion(.requestErr(decoded.message))
                    } catch {
                        completion(.pathErr)
                    }
                }

            case .failure:
                completion(.networkFail)
            }
        }
    }
}
