//
//  PoolTimeTableModel.swift
//  TeamPool
//
//  Created by 성현주 on 5/7/25.
//

import Foundation
import UIKit
import Univ_TimeTable

final class PoolTimeTableModel {

    static let shared = PoolTimeTableModel()
    private init() {}

    var pooledLectures: [Lecture] = []

    // 사용자별 색상 캐싱용
    private var userColorMap: [Int: UIColor] = [:]

    // MARK: - 실제 API 데이터로 업데이트
    func update(with dtoList: [PoolTimetableResponseDTO]) {
        self.pooledLectures = []
        self.userColorMap = [:] // 매번 새로 고침 시 초기화

        for dto in dtoList {
            let color = color(for: dto.userId)

            let lectures = dto.timetables.map {
                Lecture(
                    classroomID: UUID().uuidString,
                    name: $0.subject,
                    classroom: $0.place,
                    professor: dto.nickname,
                    courseDay: mapDayStringToEnum($0.dayOfWeek),
                    startTime: formatTime($0.startTime),
                    endTime: formatTime($0.endTime),
                    backgroundColor: color
                )
            }

            pooledLectures.append(contentsOf: lectures)
        }
    }

    // MARK: - 사용자별 랜덤 색상 반환
    private func color(for userId: Int) -> UIColor {
        if let color = userColorMap[userId] {
            return color
        } else {
            let newColor = randomColor()
            userColorMap[userId] = newColor
            return newColor
        }
    }

    // MARK: - 요일 변환
    private func mapDayStringToEnum(_ day: String) -> CourseDay {
        switch day.uppercased() {
        case "MONDAY": return .monday
        case "TUESDAY": return .tuesday
        case "WEDNESDAY": return .wednesday
        case "THURSDAY": return .thursday
        case "FRIDAY": return .friday
        default: return .monday
        }
    }

    // MARK: - 시간 포맷 "13:30:00" → "13:30"
    private func formatTime(_ time: String) -> String {
        let components = time.split(separator: ":")
        guard components.count >= 2 else { return time }
        return "\(components[0]):\(components[1])"
    }

    // MARK: - 색상 랜덤 선택
    private func randomColor() -> UIColor {
        return UIColor.timetableColors.randomElement() ?? .systemGray
    }

    // MARK: - 목업 (테스트용 유지)
    func mockData() {
        pooledLectures = []
        let lectures: [Lecture] = [
            Lecture(classroomID: "101", name: "소프트웨어공학", classroom: "IT관 101호", professor: "김소프트", courseDay: .monday, startTime: "09:00", endTime: "10:15", backgroundColor: randomColor()),
            Lecture(classroomID: "102", name: "운영체제", classroom: "IT관 102호", professor: "이운영", courseDay: .wednesday, startTime: "10:30", endTime: "11:45", backgroundColor: randomColor())
        ]
        pooledLectures.append(contentsOf: lectures)
    }
}
