



struct MyInfoModel: Codable {
    let myName: String
    let myStudentNumber: String

    enum CodingKeys: String, CodingKey {
        case myName = "name"
        case myStudentNumber = "studentNumber"
    }
}

