//
//  IslandInfoDTO.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by seozero on 5/18/25.
//

import Foundation

struct IslandInfoResponse: Codable {
    let code: String
    let message: String
    let data: IslandInfo
}

struct IslandInfo: Codable {
    let name: String
    let island_id: Int
    let island_description: String
    let image: [String]
    let category_description: String
}
