//
//  IslandInfoAPI.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by seozero on 5/18/25.
//

import Foundation
import Moya

enum IslandInfoAPI {
    case getIslandInfo(steps: Int, category: String)
}

extension IslandInfoAPI: BaseTargetType {

    var path: String {
        return "/islands"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getIslandInfo(let steps, let category):
            return .requestParameters(
                parameters: [
                    "steps": steps,
                    "category": category
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}



final class IslandInfoService {

    private let provider = MoyaProvider<IslandInfoAPI>(plugins: [MoyaLoggerPlugin()])

    func getIslandInfo(steps: Int, category: String, completion: @escaping (NetworkResult<IslandInfo>) -> Void) {
        provider.request(.getIslandInfo(steps: steps, category: category)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(IslandInfoResponse.self, from: response.data)
                    completion(.success(decoded.data.self))
                } catch {
                    print("디코딩 에러:", error)
                    completion(.pathErr)
                }

            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    
}
