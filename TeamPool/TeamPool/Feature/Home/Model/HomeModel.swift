//
//  HomeModel.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation

struct HomeModel {
    let poolId: Int
    let name: String
    let subName: String
    let date: String
    let location: String
    let participant: String
    let dDay: String

    static func dummyData() -> [HomeModel] {
        return [
            HomeModel(
                poolId: 1,
                name: "전설의 시작",
                subName: "소프트웨어 프로젝트",
                date: "2025년 03월 18일 18:00 - 19:15",
                location: "정보과학관 21304",
                participant: "성현주 외 4명",
                dDay: "D-72"
            ),
            HomeModel(
                poolId: 2,
                name: "알고리즘 스터디",
                subName: "소프트웨어 프로젝트",
                date: "2025년 03월 20일 13:00 - 15:00",
                location: "정보과학관 21203",
                participant: "김영희 외 3명",
                dDay: "D-75"
            ),
            HomeModel(
                poolId: 3,
                name: "소프트웨어 프로젝트",
                subName: "소프트웨어 프로젝트",
                date: "2025년 03월 25일 17:00 - 18:30",
                location: "정보과학관 21305",
                participant: "박철수 외 5명",
                dDay: "D-80"
            ),
            HomeModel(
                poolId: 4,
                name: "소프트웨어 프로젝트",
                subName: "소프트웨어 프로젝트",
                date: "2025년 03월 25일 17:00 - 18:30",
                location: "정보과학관 21305",
                participant: "박철수 외 5명",
                dDay: "D-80"
            ),
            HomeModel(
                poolId: 5,
                name: "소프트웨어 프로젝트",
                subName: "소프트웨어 프로젝트",
                date: "2025년 03월 25일 17:00 - 18:30",
                location: "정보과학관 21305",
                participant: "박철수 외 5명",
                dDay: "D-80"
            )
        ]
    }
}
