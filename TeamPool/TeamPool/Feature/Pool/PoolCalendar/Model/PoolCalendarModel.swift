//
//  File.swift
//  TeamPool
//
//  Created by Mac on 5/11/25.
//
import Foundation
import UIKit

struct PoolCalendarModel {
    let subjectName: String
    let title: String
    let startDate: Date
    let endDate: Date
    let place: String
    let color: UIColor
    
    static func dummyData() -> [PoolCalendarModel] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return [
            PoolCalendarModel(
                subjectName: "1차 회의",
                title: "전설의 시작",
                startDate: formatter.date(from: "2025-05-11T05:06")!,
                endDate: formatter.date(from: "2025-05-11T06:06")!,
                place: "정보과학관 B1 슈게더",
                color: UIColor.CalendarColar1
            )
        ]
    }
}

extension PoolCalendarModel {
    init(from dto: ScheduleResponseDTO) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "ko_KR")

        self.subjectName = dto.title
        self.title = dto.title
        self.startDate = formatter.date(from: dto.startDatetime) ?? Date()
        self.endDate = formatter.date(from: dto.endDatetime) ?? Date()
        self.place = dto.place

        let colors: [UIColor] = [.CalendarColar1, .CalendarColar2, .CalendarColar3, .CalendarColar4]
        self.color = colors.randomElement() ?? .gray
    }
}

