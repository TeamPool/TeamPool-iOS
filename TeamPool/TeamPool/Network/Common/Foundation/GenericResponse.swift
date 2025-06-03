//
//  GenericResponse.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/17/25.
//

import Foundation

struct GenericResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
