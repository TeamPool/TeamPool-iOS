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
            subName: dto.poolSubject,
            date: dto.deadline,
            participant: formatParticipant(from: dto.members),
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

    private static func formatParticipant(from members: [String]) -> String {
        guard let first = members.first else { return "0명" }

        let others = members.count - 1

        switch others {
        case 0: return "\(first) 단독"
        case 1: return "\(first) 외 1명"
        default: return "\(first) 외 \(others)명"
        }
    }
}

struct MemberDTO: Decodable {
    let name: String
    let studentNumber: String
}
