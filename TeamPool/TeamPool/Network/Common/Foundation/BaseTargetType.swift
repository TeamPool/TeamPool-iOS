//
//  BaseTargetType.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/17/25.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType{

    var baseURL: URL {
        /// 실제 url로 바꿔주세요.
//        return URL(string: "https://62268471-962b-47f7-bf38-92dd2a82213e.mock.pstmn.io/")!
        return URL(string:"http://43.201.115.250:8080")!
    }

    var headers: [String : String]? {
        let header = [
            "Content-Type": "application/json"
        ]
        return header
    }

    var sampleData: Data {
        return Data()
    }
}
