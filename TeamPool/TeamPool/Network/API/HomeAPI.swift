//
//  HomeAPI.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/17/25.
//

import Foundation
import Moya

enum AuthAPI {
    case login(body: LoginRequestDTO)
    case signUp(body: SignUpRequestDTO)
}

extension AuthAPI: BaseTargetType {

    var path: String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .signUp:
            return "/api/auth/signup"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login, .signUp:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .login(let body):
            return .requestJSONEncodable(body)
        case .signUp(let body):
            return .requestJSONEncodable(body)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

final class AuthService {

    private let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggerPlugin()])

    func login(requestDTO: LoginRequestDTO, completion: @escaping (NetworkResult<LoginResponseDTO>) -> Void) {
        provider.request(.login(body: requestDTO)) { (result: Result<Response, MoyaError>) in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200..<300:
                    do {
                        let decoded = try JSONDecoder().decode(APIResponse<LoginResponseDTO>.self, from: response.data)
                        completion(.success(decoded.data))
                    } catch {
                        print("디코딩 에러:", error)
                        print("응답 문자열:\n" + (String(data: response.data, encoding: .utf8) ?? "없음"))
                        completion(.pathErr)
                    }

                case 400..<500:
                    if let error = try? JSONDecoder().decode(ErrorResponseDTO.self, from: response.data) {
                        completion(.requestErr(error.message))
                    } else {
                        completion(.requestErr("알 수 없는 클라이언트 오류"))
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

extension AuthService {
    func signUp(requestDTO: SignUpRequestDTO, completion: @escaping (NetworkResult<String>) -> Void) {
        provider.request(.signUp(body: requestDTO)) { (result: Result<Response, MoyaError>) in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200..<300:
                    do {
                        let decoded = try JSONDecoder().decode(APIResponse<String>.self, from: response.data)
                        completion(.success(decoded.data))
                    } catch {
                        print("디코딩 에러:", error)
                        print("응답 문자열:\n" + (String(data: response.data, encoding: .utf8) ?? "없음"))
                        completion(.pathErr)
                    }

                case 400..<500:
                    if let error = try? JSONDecoder().decode(ErrorResponseDTO.self, from: response.data) {
                        completion(.requestErr(error.message))
                    } else {
                        completion(.requestErr("알 수 없는 클라이언트 오류"))
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
