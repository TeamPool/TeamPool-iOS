//
//  CalendarViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation
import UIKit

final class CalendarViewController: BaseUIViewController {

    // MARK: - UI Components
    private let calendarView = CalendarView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar"
        fetchMySchedules()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMySchedules()
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(calendarView)
    }

    override func setLayout() {
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func fetchMySchedules() {
        AddPoolScheduleService().fetchMySchedules { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let schedules):
                let allSchedules = schedules.flatMap { $0.schedules }
                let models = allSchedules.map { CalendarModel(from: $0) }

                self.calendarView.updateEvents(models)
                self.presentTodayDetailModal(with: models) 
            case .requestErr(let msg):
                self.showAlert(title: "내 일정 조회 실패", message: msg)

            case .networkFail:
                self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")

            default:
                self.showAlert(title: "오류", message: "일정을 가져올 수 없습니다.")
            }
        }
    }


    private func presentTodayDetailModal(with events: [CalendarModel]) {
        let today = Date()
        let filteredEvents = events.filter {
            guard let range = Calendar.current.dateInterval(of: .day, for: today) else { return false }
            return $0.startDate <= range.end && $0.endDate >= range.start
        }

        let detailVC = CalendarDetailViewController(date: today, events: filteredEvents)
        detailVC.modalPresentationStyle = .pageSheet

        if let sheet = detailVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }

        present(detailVC, animated: true)
    }


    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}

extension CalendarModel {
    init(from dto: MyScheduleResponseDTO.ScheduleDTO) {
        self.subjectName = ""
        self.title = dto.title
        self.place = dto.place
        self.color = UIColor.timetableColors.randomElement() ?? .systemGray

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        self.startDate = formatter.date(from: dto.startDatetime) ?? Date()
        self.endDate = formatter.date(from: dto.endDatetime) ?? Date()
    }
}
