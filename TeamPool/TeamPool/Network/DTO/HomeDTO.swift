//
//  HomeDTO.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/18/25.
//

import Foundation

struct HomeStepResponse: Codable {
    let code: String
    let message: String
    let data: StepInfo
}

struct StepInfo: Codable {
    let totalStep: Int
    let remainStep: Int
    let islandCount: Int
}
