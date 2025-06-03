//
//  APIResponse.swift
//  TeamPool
//
//  Created by 성현주 on 6/3/25.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let code: String
    let message: String
    let data: T
}
