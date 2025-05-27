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

