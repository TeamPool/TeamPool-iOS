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

struct MyPoolListResponseDTO: Codable {
    let poolId: Int
    let name: String
    let subject: String
    let deadline: String
}


struct PoolTimetableResponseDTO: Codable {
    let userId: Int
    let nickname: String
    let timetables: [TimetableDTO]
}

struct TimetableDTO: Codable {
    let dayOfWeek: String
    let subject: String
    let startTime: String
    let endTime: String
    let place: String
}
