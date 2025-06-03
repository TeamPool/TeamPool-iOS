//
//  PoolDTO.swift
//  TeamPool
//
//  Created by 성현주 on 6/4/25.
//

import Foundation

struct PoolCreateRequestDTO: Codable {
    let name: String
    let subject: String
    let poolSubject: String
    let deadline: String
    let memberStudentNumbers: [String]
}

struct PoolCreateResponseDTO: Codable {
    let poolId: Int
}
