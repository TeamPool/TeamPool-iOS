//
//  LectureModel.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation
import UIKit
import Rusaint

enum CourseDay: Int {
    case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday
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
