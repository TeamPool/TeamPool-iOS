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
    let participant: String
    let dDay: String
}

extension HomeModel {
    static func from(dto: MyPoolListResponseDTO) -> HomeModel {
        return HomeModel(
            poolId: dto.poolId,
            name: dto.name,
            subName: dto.poolSubject, // 팀플 주제
            date: dto.deadline,
            participant: "\(dto.members.count)명", // 참가자 수
            dDay: calculateDDay(from: dto.deadline)
        )
    }

    private static func calculateDDay(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let targetDate = formatter.date(from: dateString) else {
            return "D-?"
        }
        let days = Calendar.current.dateComponents([.day], from: Date(), to: targetDate).day ?? 0
        return "D-\(days)"
    }
}
