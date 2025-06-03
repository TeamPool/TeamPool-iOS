//
//  PoolCreateDataSource.swift
//  TeamPool
//
//  Created by 성현주 on 6/4/25.
//

import Foundation

final class PoolCreateDataStore {
    static let shared = PoolCreateDataStore()
    private init() {}

    // MARK: - 저장 프로퍼티
    var name: String?
    var subject: String?
    var poolSubject: String?
    var deadline: String?
    var memberStudentNumbers: [String] = []

    // MARK: - 값 초기화
    func reset() {
        name = nil
        subject = nil
        poolSubject = nil
        deadline = nil
        memberStudentNumbers = []
    }

    // MARK: - DTO 생성
    func generateDTO() -> PoolCreateRequestDTO? {
        guard let name = name,
              let subject = subject,
              let poolSubject = poolSubject,
              let deadline = deadline,
              !memberStudentNumbers.isEmpty else {
            return nil // 필수값 누락 시 nil 반환
        }

        return PoolCreateRequestDTO(
            name: name,
            subject: subject,
            poolSubject: poolSubject,
            deadline: deadline,
            memberStudentNumbers: memberStudentNumbers
        )
    }
}
