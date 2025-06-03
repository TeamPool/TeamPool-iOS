//
//  AuthAPI.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/17/25.
//

import Foundation
import Moya

enum AuthAPI {
    case login(body: LoginRequestDTO)
    case signUp(body: SignUpRequestDTO)
    case checkStudentNumberDup(studentNumber: String)
    case checkNicknameDup(nickname: String)
    case refreshToken(body: RefreshTokenRequestDTO)
}

extension AuthAPI: BaseTargetType {

    var path: String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .signUp:
            return "/api/auth/signup"
        case .checkStudentNumberDup:
            return "/api/auth/studentNumber-signup-dup"
        case .checkNicknameDup:
            return "/api/auth/nickname-signup-dup"
        case .refreshToken:
                return "/api/auth/refresh"
            }
    }

    var method: Moya.Method {
        switch self {
        case .login, .signUp:
            return .post
        case .checkStudentNumberDup, .checkNicknameDup:
            return .get
        case .refreshToken:
                return .post
            }
    }

    var task: Moya.Task {
        switch self {
        case .login(let body):
            return .requestJSONEncodable(body)
        case .signUp(let body):
            return .requestJSONEncodable(body)
        case .checkStudentNumberDup(let studentNumber):
            return .requestParameters(parameters: ["studentNumber": studentNumber], encoding: URLEncoding.queryString)
        case .checkNicknameDup(let nickname):
            return .requestParameters(parameters: ["nickname": nickname], encoding: URLEncoding.queryString)
        case .refreshToken(let body):
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


extension AuthService {

    func checkStudentNumberDup(_ studentNumber: String, completion: @escaping (NetworkResult<Void>) -> Void) {
        provider.request(.checkStudentNumberDup(studentNumber: studentNumber)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200..<300:
                    completion(.success(())) // 성공이면 특별한 데이터 없음
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

    func checkNicknameDup(_ nickname: String, completion: @escaping (NetworkResult<Void>) -> Void) {
        provider.request(.checkNicknameDup(nickname: nickname)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200..<300:
                    completion(.success(())) // 사용 가능
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
    func refreshToken(completion: @escaping (NetworkResult<String>) -> Void) {
        let requestDTO = RefreshTokenRequestDTO(refreshToken: UserDefaultHandler.refreshToken)

        provider.request(.refreshToken(body: requestDTO)) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200..<300:
                    do {
                        let decoded = try JSONDecoder().decode(APIResponse<RefreshTokenResponseDTO>.self, from: response.data)
                        completion(.success(decoded.data.accessToken))
                    } catch {
                        print("디코딩 에러:", error)
                        completion(.pathErr)
                    }

                case 400..<500:
                    if let error = try? JSONDecoder().decode(ErrorResponseDTO.self, from: response.data) {
                        completion(.requestErr(error.message))
                    } else {
                        completion(.requestErr("리프레시 토큰 오류"))
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
