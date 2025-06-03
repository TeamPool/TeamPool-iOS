//
//  NetworkResult.swift
//  36-SOPKATHON-iOS-TEAM-3
//
//  Created by 성현주 on 5/17/25.
//

import Foundation

enum NetworkResult<T> {
    case success(T)                    // 서버 통신 성공
    case requestErr(String)                 // 요청 에러 발생
    case pathErr                       // 경로 에러 발생
    case serverErr                     // 서버의 내부적 에러가 발생
    case networkFail                   // 네트워크 연결 실패
}
