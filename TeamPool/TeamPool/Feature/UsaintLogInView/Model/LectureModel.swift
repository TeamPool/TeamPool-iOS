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

    func randomColor() -> UIColor {
        return UIColor.timetableColors.randomElement() ?? .systemGray
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


extension Lecture {
    func toRequestDTO() -> TimeTableRequestDTO {
        return TimeTableRequestDTO(
            dayOfWeek: courseDay.toServerString(),
            subject: name,
            startTime: convertToTimeString(from: startTime),
            endTime: convertToTimeString(from: endTime),
            place: classroom
        )
    }

    private func convertToTimeString(from time: String) -> String {
        // "9:00" → "09:00:00"
        let components = time.split(separator: ":").map { Int($0) ?? 0 }
        let hour = String(format: "%02d", components.count > 0 ? components[0] : 0)
        let minute = String(format: "%02d", components.count > 1 ? components[1] : 0)
        return "\(hour):\(minute):00"
    }
}

extension CourseDay {
    func toServerString() -> String {
        switch self {
        case .monday: return "MONDAY"
        case .tuesday: return "TUESDAY"
        case .wednesday: return "WEDNESDAY"
        case .thursday: return "THURSDAY"
        case .friday: return "FRIDAY"
        case .saturday: return "SATURDAY"
        case .sunday: return "SUNDAY"
        }
    }
}
