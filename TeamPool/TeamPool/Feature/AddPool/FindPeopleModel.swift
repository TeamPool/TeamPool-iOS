//
//  MyPageModel.swift
//  TeamPool
//
//  Created by Mac on 4/6/25.
//

import Foundation

struct FindPeopleModel {
    let friendId: Int?
    let nickname: String
    let studentNumber: String

    var name: String { nickname }

    init(friendId: Int?, nickname: String, studentNumber: String) {
        self.friendId = friendId
        self.nickname = nickname
        self.studentNumber = studentNumber
    }

    init(from dto: FriendDTO) {
        self.friendId = dto.friendId
        self.nickname = dto.nickname
        self.studentNumber = dto.studentNumber
    }
}


struct SearchFriendDTO: Codable {
    let nickname: String
    let studentNumber: String
}
