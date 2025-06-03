//
//  CommentsDTO.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/18/25.
//

import Foundation

struct IslandCommentResponse: Codable {
    let code: String
    let message: String
    let data: [IslandComment]
}

struct IslandComment: Codable {
    let commentId: Int
    let islandId: Int
    let comment: String?
}

struct PostCommentRequest: Codable {
    let comment: String
}
