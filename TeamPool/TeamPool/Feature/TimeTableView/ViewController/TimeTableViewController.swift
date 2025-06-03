//
//  TimeTableViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation
import Rusaint
import Univ_TimeTable
import UIKit

final class TimeTableViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let timeTableView = TimeTableView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegate()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(timeTableView)
    }

    override func setLayout() {
        timeTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addDelegate(){
        timeTableView.timeTable.dataSource = self
    }

    // MARK: - Action Method

    override func addTarget() {
        timeTableView.callTimeTableButton.addTarget(self, action: #selector(didTappedCallTimeTableButton), for: .touchUpInside)
    }

    @objc
    func didTappedCallTimeTableButton() {
        let dtoList = LectureModel.shared.lectures.map { $0.toRequestDTO() }

        TimeTableService().postTimeTables(dtoList) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success:
                    print("✅ 시간표 서버 전송 성공")
                    self.showAlertWithDismiss(title: "성공", message: "시간표가 성공적으로 저장되었습니다.")

                case .requestErr(let msg):
                    self.showAlert(title: "실패", message: msg)

                case .networkFail:
                    self.showAlert(title: "실패", message: "네트워크 오류가 발생했습니다.")

                default:
                    self.showAlert(title: "실패", message: "알 수 없는 오류가 발생했습니다.")
                }
            }
        }
    }

    // MARK: - Alert Helper

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }

    private func showAlertWithDismiss(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(confirm)
        self.present(alert, animated: true)
    }
}

// MARK: - UnivTimeTableDataSource

extension TimeTableViewController: UnivTimeTableDataSource {

    func numberOfDays(in univTimeTable: UnivTimeTable) -> Int {
        return 5 // 월~금
    }

    func univTimeTable(univTimeTable: UnivTimeTable, at dayPerIndex: Int) -> String {
        return ["월", "화", "수", "목", "금"][dayPerIndex]
    }

    func courseItems(in univTimeTable: UnivTimeTable) -> [Univ_TimeTable.Lecture] {
        return LectureModel.shared.lectures.map { $0.toUnivLecture() }
    }
}
