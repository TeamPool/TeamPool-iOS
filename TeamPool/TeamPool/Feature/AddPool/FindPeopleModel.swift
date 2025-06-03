//
//  MyPageModel.swift
//  TeamPool
//
//  Created by Mac on 4/6/25.
//

import Foundation

struct FindPeopleModel {
    let friendId: Int
    let nickname: String
    let studentNumber: String

    var name: String { nickname }

    init(from dto: FriendDTO) {
        self.friendId = dto.friendId
        self.nickname = dto.nickname
        self.studentNumber = dto.studentNumber
    }
}
