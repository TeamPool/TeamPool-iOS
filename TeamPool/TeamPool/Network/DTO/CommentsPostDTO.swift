//
//  CommentsPostDTO.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/18/25.
//

import Foundation

// MARK: - Request Body 모델
struct CommentRequest: Codable {
    let comment: String
}

// MARK: - Response 모델
struct CommentPostResponse: Codable {
    let code: String
    let message: String
}

