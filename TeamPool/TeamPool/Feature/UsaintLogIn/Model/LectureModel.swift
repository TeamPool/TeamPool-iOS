//
//  LectureModel.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation
import UIKit
import Rusaint
import Univ_TimeTable

enum CourseDay: Int {
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday
}

struct Lecture {
    let classroomID: String
    let name: String
    let classroom: String
    let professor: String
    let courseDay: CourseDay
    let startTime: String
    let endTime: String
    let backgroundColor: UIColor
}

final class LectureModel {
    static let shared = LectureModel()

    private init() {}

    var lectures: [Lecture] = []

    func reset() {
        lectures = []
    }

    // ✅ Weekday -> CourseDay 변환
    func weekDayToCourseDay(_ weekday: Weekday) -> CourseDay {
        switch weekday {
        case .mon: return .monday
        case .tue: return .tuesday
        case .wed: return .wednesday
        case .thu: return .thursday
        case .fri: return .friday
        case .sat: return .saturday
        case .sun: return .sunday
        }
    }

    // ✅ 색상 랜덤 선택
    func randomColor() -> UIColor {
        let colors: [UIColor] = [
            .systemRed, .systemBlue, .systemGreen, .systemOrange,
            .systemPurple, .systemYellow, .systemTeal, .systemPink
        ]
        return colors.randomElement() ?? .systemGray
    }
}

extension LectureModel {
    func getLectureNames() -> [String] {
        let names = lectures.map { $0.name }
        let uniqueNames = Array(Set(names))
        return uniqueNames.sorted()        
    }
}


extension TeamPool.Lecture {
    func toUnivLecture() -> Univ_TimeTable.Lecture {
        return Univ_TimeTable.Lecture(
            classroomID: self.classroomID,
            name: self.name,
            classroom: self.classroom,
            professor: self.professor,
            courseDay: Univ_TimeTable.Day(rawValue: self.courseDay.rawValue) ?? .monday,
            startTime: self.startTime,
            endTime: self.endTime,
            backgroundColor: self.backgroundColor
        )
    }
}
