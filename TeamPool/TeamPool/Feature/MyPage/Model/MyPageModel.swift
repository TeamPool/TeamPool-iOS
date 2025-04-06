//
//  MyPageModel.swift
//  TeamPool
//
//  Created by Mac on 4/6/25.
//

import Foundation

struct MyPageModel {
    let name : String
    let studentNumber : String
    
    static func dummyData() -> [MyPageModel] {
        return [
            MyPageModel(
                name : "하준",
                studentNumber : "20233048"
            ),
            MyPageModel(
                name : "다인",
                studentNumber: "20231708"
            )
        ]
    }
}
