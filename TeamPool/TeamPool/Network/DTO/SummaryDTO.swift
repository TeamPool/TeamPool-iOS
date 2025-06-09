//
//  SummaryDTO.swift
//  TeamPool
//
//  Created by 성현주 on 6/10/25.
//

import Foundation
struct ChatGPTRequestDTO: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
    let temperature: Double
}

struct OpenAIChatMessage: Encodable {
    let role: String
    let content: String
}

struct ChatGPTResponseDTO: Decodable {
    let choices: [Choice]

    struct Choice: Decodable {
        let message: Message
    }

    struct Message: Decodable {
        let role: String
        let content: String
    }
}
