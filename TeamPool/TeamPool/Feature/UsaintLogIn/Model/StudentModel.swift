//
//  StudentModel.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation

final class StudentModel {

    static let shared = StudentModel()

    private init() {}

    var studentID: String?
    var name: String?
    var major: String?
    var schoolYear: String?

    func reset() {
        studentID = nil
        name = nil
        major = nil
        schoolYear = nil
    }
}

