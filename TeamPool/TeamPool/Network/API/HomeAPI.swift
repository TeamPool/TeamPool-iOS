//
//  HomeAPI.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/17/25.
//




import Foundation
import Moya

enum HomeAPI {
    case getHomeStep(userID: Int)
}

extension HomeAPI: BaseTargetType {

    var path: String {
        switch self {
        case .getHomeStep(let userID):
            return "/islands/steps/\(userID)" 
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}



final class HomeService {

    private let provider = MoyaProvider<HomeAPI>(plugins: [MoyaLoggerPlugin()])

    func getHomeStep(userID: Int, completion: @escaping (NetworkResult<StepInfo>) -> Void) {
        provider.request(.getHomeStep(userID: userID)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(HomeStepResponse.self, from: response.data)
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
