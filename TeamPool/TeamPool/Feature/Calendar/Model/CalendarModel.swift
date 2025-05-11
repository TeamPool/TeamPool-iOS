//
//  File.swift
//  TeamPool
//
//  Created by Mac on 5/11/25.
//
import Foundation
import UIKit

struct CalendarModel {
    let subjectName: String
    let title: String
    let startDate: Date
    let endDate: Date
    let place: String
    let color: UIColor
    
    static func dummyData() -> [CalendarModel] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return [
            CalendarModel(
                subjectName: "소프트웨어 프로젝트",
                title: "전설의 시작",
                startDate: formatter.date(from: "2025-05-11T05:06")!,
                endDate: formatter.date(from: "2025-05-14T06:06")!,
                place: "정보과학관 B1 슈게더",
                color: UIColor.CalendarColar1
            ),
            CalendarModel(
                subjectName: "자료구조",
                title: "과제 제출",
                startDate: formatter.date(from: "2025-05-11T10:00")!,
                endDate: formatter.date(from: "2025-05-11T12:00")!,
                place: "온라인",
                color: UIColor.CalendarColar2
            ),
            CalendarModel(
                subjectName: "프로그래밍 언어",
                title: "할부지 면담",
                startDate: formatter.date(from: "2025-05-11T10:00")!,
                endDate: formatter.date(from: "2025-05-16T14:00")!,
                place: "정보과학관 306",
                color: UIColor.CalendarColar3
            )
        ]
    }
}

