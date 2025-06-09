import Foundation

struct PoolProceedingModel {
    let date: Date
    let title: String
    let description: String

    var shortDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: date)
    }

    var dateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    static func dummyData() -> [PoolProceedingModel] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return [
            PoolProceedingModel(date: formatter.date(from: "2025-04-03")!, title: "회의 제목", description: "회의 내용이 어쩌구 저쩌구 쌀라쌀라 들어가겠죠??\n귀찮으니 이만 말을 줄일게요"),
            PoolProceedingModel(date: formatter.date(from: "2025-04-05")!, title: "회의 제목", description: "간단한 회의입니다."),
            PoolProceedingModel(date: formatter.date(from: "2025-04-13")!, title: "회의 제목", description: "이건 테스트 회의입니다."),
            PoolProceedingModel(date: formatter.date(from: "2025-04-20")!, title: "회의 제목", description: "이건 마지막 더미입니다.")
        ]
    }
}


extension PoolProceedingModel {
    init(from dto: PoolNoteResponseDTO) {
        self.title = dto.title
        self.description = dto.summary
        let components = DateComponents(hour: dto.time.hour, minute: dto.time.minute, second: dto.time.second, nanosecond: dto.time.nano)
        self.date = Calendar.current.date(from: components) ?? Date()
    }
}

