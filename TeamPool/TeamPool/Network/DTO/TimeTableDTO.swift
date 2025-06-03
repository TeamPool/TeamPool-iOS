//
//  TimeTableDTO.swift
//  TeamPool
//
//  Created by 성현주 on 6/4/25.
//

import Foundation

struct TimeTableRequestDTO: Codable {
    let dayOfWeek: String       // "MONDAY", "TUESDAY" 등
    let subject: String
    let startTime: String
    let endTime: String
    let place: String
}

struct TimeDTO: Codable {
    let hour: Int
    let minute: Int
    let second: Int
    let nano: Int
}
