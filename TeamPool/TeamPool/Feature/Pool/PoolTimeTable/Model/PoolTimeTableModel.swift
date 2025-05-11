//
//  PoolTimeTableModel.swift
//  TeamPool
//
//  Created by 성현주 on 5/7/25.
//

import Foundation
import UIKit

final class PoolTimeTableModel {

    static let shared = PoolTimeTableModel()
    private init() {}

    var pooledLectures: [Lecture] = []

    func mockData() {
        pooledLectures = []

        let lectures: [Lecture] = [

            Lecture(classroomID: "101", name: "소프트웨어공학", classroom: "IT관 101호", professor: "김소프트", courseDay: .monday, startTime: "09:00", endTime: "10:15", backgroundColor: randomColor()),
            Lecture(classroomID: "102", name: "운영체제", classroom: "IT관 102호", professor: "이운영", courseDay: .wednesday, startTime: "10:30", endTime: "11:45", backgroundColor: randomColor()),
            Lecture(classroomID: "103", name: "자료구조", classroom: "IT관 103호", professor: "최자료", courseDay: .friday, startTime: "11:00", endTime: "12:15", backgroundColor: randomColor()),

            Lecture(classroomID: "201", name: "네트워크", classroom: "IT관 201호", professor: "정네트", courseDay: .tuesday, startTime: "13:00", endTime: "14:15", backgroundColor: randomColor()),
            Lecture(classroomID: "202", name: "데이터베이스", classroom: "IT관 202호", professor: "박데이", courseDay: .thursday, startTime: "14:30", endTime: "15:45", backgroundColor: randomColor()),
            Lecture(classroomID: "203", name: "컴퓨터구조", classroom: "IT관 203호", professor: "구조쌤", courseDay: .friday, startTime: "09:00", endTime: "10:15", backgroundColor: randomColor()),

            Lecture(classroomID: "301", name: "운영체제", classroom: "IT관 102호", professor: "이운영", courseDay: .monday, startTime: "13:00", endTime: "14:15", backgroundColor: randomColor()),
            Lecture(classroomID: "302", name: "알고리즘", classroom: "IT관 302호", professor: "알쌤", courseDay: .tuesday, startTime: "15:00", endTime: "16:15", backgroundColor: randomColor()),
            Lecture(classroomID: "303", name: "인공지능", classroom: "IT관 303호", professor: "AI박사", courseDay: .thursday, startTime: "10:30", endTime: "11:45", backgroundColor: randomColor()),

            Lecture(classroomID: "401", name: "컴퓨터비전", classroom: "IT관 401호", professor: "비전쌤", courseDay: .monday, startTime: "15:00", endTime: "16:15", backgroundColor: randomColor()),
            Lecture(classroomID: "402", name: "기계학습", classroom: "IT관 402호", professor: "머신쌤", courseDay: .tuesday, startTime: "11:00", endTime: "12:15", backgroundColor: randomColor()),
            Lecture(classroomID: "403", name: "심층학습", classroom: "IT관 403호", professor: "딥쌤", courseDay: .wednesday, startTime: "14:00", endTime: "15:15", backgroundColor: randomColor()),

            Lecture(classroomID: "501", name: "모바일프로그래밍", classroom: "IT관 501호", professor: "스위프트", courseDay: .friday, startTime: "13:00", endTime: "14:15", backgroundColor: randomColor()),
            Lecture(classroomID: "502", name: "웹개발", classroom: "IT관 502호", professor: "리액트쌤", courseDay: .thursday, startTime: "16:00", endTime: "17:15", backgroundColor: randomColor()),
            Lecture(classroomID: "503", name: "클라우드컴퓨팅", classroom: "IT관 503호", professor: "클라우드쌤", courseDay: .monday, startTime: "10:30", endTime: "11:45", backgroundColor: randomColor()),

            Lecture(classroomID: "601", name: "소프트웨어테스팅", classroom: "IT관 601호", professor: "테스트쌤", courseDay: .wednesday, startTime: "09:00", endTime: "10:15", backgroundColor: randomColor()),
            Lecture(classroomID: "602", name: "정보보안", classroom: "IT관 602호", professor: "보안쌤", courseDay: .tuesday, startTime: "14:00", endTime: "15:15", backgroundColor: randomColor()),
            Lecture(classroomID: "603", name: "데이터사이언스", classroom: "IT관 603호", professor: "데사쌤", courseDay: .friday, startTime: "15:00", endTime: "16:15", backgroundColor: randomColor())
        ]

        pooledLectures.append(contentsOf: lectures)
    }

    private func randomColor() -> UIColor {
        return UIColor.timetableColors.randomElement() ?? .systemGray
    }
}
