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

struct TimeTableResponseDTO: Codable {
    let dayOfWeek: String
    let subject: String
    let startTime: String
    let endTime: String
    let place: String
}


extension TimeTableResponseDTO {
    func toLecture() -> Lecture {
        // 요일 매핑
        let courseDayMap: [String: CourseDay] = [
            "MONDAY": .monday,
            "TUESDAY": .tuesday,
            "WEDNESDAY": .wednesday,
            "THURSDAY": .thursday,
            "FRIDAY": .friday,
            "SATURDAY": .saturday,
            "SUNDAY": .sunday
        ]

        return Lecture(
            classroomID: UUID().uuidString,
            name: subject,
            classroom: place,
            professor: "",
            courseDay: courseDayMap[dayOfWeek.uppercased()] ?? .monday,
            startTime: String(startTime.prefix(5)),
            endTime: String(endTime.prefix(5)),    
            backgroundColor: LectureModel.shared.randomColor()
        )
    }
}
