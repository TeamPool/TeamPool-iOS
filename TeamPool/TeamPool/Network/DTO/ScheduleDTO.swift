//
//  ScheduleDTO.swift
//  TeamPool
//
//  Created by 성현주 on 6/4/25.
//

import Foundation
struct ScheduleCreateRequestDTO: Codable {
    let poolId: Int
    let title: String
    let startDatetime: String 
    let endDatetime: String
    let place: String
}
