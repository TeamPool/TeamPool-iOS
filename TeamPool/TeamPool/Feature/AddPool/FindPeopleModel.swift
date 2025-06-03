//
//  MyPageModel.swift
//  TeamPool
//
//  Created by Mac on 4/6/25.
//

import Foundation

struct FindPeopleModel {
    let name : String
    let studentNumber : String
    
    static func dummyData() -> [FindPeopleModel] {
        return [
            FindPeopleModel(
                name : "하준",
                studentNumber : "20233048"
            ),
            FindPeopleModel(
                name : "다인",
                studentNumber: "20231708"
            ),
            FindPeopleModel(
                name : "지수",
                studentNumber: "20231709"
            ),
            FindPeopleModel(
                name : "진우",
                studentNumber: "20231712"
            ),
            FindPeopleModel(
                name : "현주",
                studentNumber: "20231745"
            )
        ]
    }
}


