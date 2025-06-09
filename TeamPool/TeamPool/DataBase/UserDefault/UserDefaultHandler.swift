//
//  UserDefaultHandler.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation

struct UserDefaultHandler {
    @UserDefault(key: "accessToken", defaultValue: "")
    static var accessToken: String

    @UserDefault(key: "refreshToken", defaultValue: "")
    static var refreshToken: String
}
