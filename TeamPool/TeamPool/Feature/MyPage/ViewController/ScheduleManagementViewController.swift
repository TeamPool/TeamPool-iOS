//
//  ScheduleManagementViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation
import UIKit
import Univ_TimeTable

final class ScheduleManagementViewController: BaseUIViewController {

    // MARK: - UI Components

    private let scheduleManagementView = ScheduleManagementView()

    // MARK: - Properties

    private var lectures: [Lecture] = []
    private let timeTableService = TimeTableService()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCustomBackButton()
        scheduleManagementView.timeTable.dataSource = self
        fetchMyTimeTable()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.backgroundColor = UIColor(hex: 0xEFF5FF)
        view.addSubview(scheduleManagementView)
    }

    override func setLayout() {
        scheduleManagementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - 시간표 불러오기

    private func fetchMyTimeTable() {
        timeTableService.getMyTimeTables { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let dtos):
                    self.lectures = dtos.map { $0.toLecture() }
                    self.scheduleManagementView.timeTable.reloadData()
                case .requestErr(let msg):
                    self.showAlert(title: "시간표 조회 실패", message: msg)
                case .networkFail:
                    self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")
                default:
                    self.showAlert(title: "오류", message: "시간표를 불러올 수 없습니다.")
                }
            }
        }
    }

    // MARK: - Alert

    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }

    // MARK: - 커스텀 백버튼

    private func configureCustomBackButton() {
        let backButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        backButton.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        backButton.setTitle(" 시간표 관리", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        let backItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backItem
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UnivTimeTableDataSource

extension ScheduleManagementViewController: UnivTimeTableDataSource {
    func courseItems(in univTimeTable: Univ_TimeTable.UnivTimeTable) -> [Univ_TimeTable.Lecture] {
        return lectures.map { $0.toUnivLecture() }
    }

    func numberOfDays(in univTimeTable: UnivTimeTable) -> Int {
        return 5 // 월~금
    }

    func univTimeTable(univTimeTable: UnivTimeTable, at dayPerIndex: Int) -> String {
        return ["월", "화", "수", "목", "금"][dayPerIndex]
    }

    func courseItems(in univTimeTable: UnivTimeTable) -> [Lecture] {
        return lectures
    }
}
