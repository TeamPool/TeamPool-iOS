//
//  AuthDTO.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/18/25.
//

import Foundation

struct LoginRequestDTO: Encodable {
    let studentNumber: String
    let password: String
}

struct LoginResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
}

struct SignUpRequestDTO: Encodable {
    let studentNumber: String
    let nickname: String
    let password: String
}


struct ErrorResponseDTO: Decodable {
    let code: Int
    let message: String
}

