//
//  PoolTimeTableViewController.swift
//  TeamPool
//
//  Created by 성현주 on 5/7/25.
//

import Foundation
import Foundation
import Rusaint
import Univ_TimeTable
import UIKit

final class PoolTimeTableViewController: BaseUIViewController {

    var poolId: Int
    private let poolTimeTableView = PoolTimeTableView()

    init(poolId: Int) {
        self.poolId = poolId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPoolTimetables()
        addDelegate()
    }

    override func setUI() {
        view.addSubview(poolTimeTableView)
    }

    override func setLayout() {
        poolTimeTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let availableVC = PoolAvailableTimeViewController(poolId: poolId)
        if let sheet = availableVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(availableVC, animated: true)
    }


    private func addDelegate() {
        poolTimeTableView.timeTable.dataSource = self
    }

    private func fetchPoolTimetables() {
        PoolService().fetchPoolTimetables(poolId: poolId, completion: { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    PoolTimeTableModel.shared.update(with: data)
                    self.poolTimeTableView.timeTable.reloadData()

                case .requestErr(let msg):
                    self.showAlert(title: "조회 실패", message: msg)

                case .networkFail:
                    self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")

                default:
                    self.showAlert(title: "오류", message: "시간표를 불러오지 못했습니다.")
                }
            }
        })
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}


// MARK: - UnivTimeTableDataSource

extension PoolTimeTableViewController: UnivTimeTableDataSource {

    func numberOfDays(in univTimeTable: UnivTimeTable) -> Int {
        return 5 // 월~금
    }

    func univTimeTable(univTimeTable: UnivTimeTable, at dayPerIndex: Int) -> String {
        return ["월", "화", "수", "목", "금"][dayPerIndex]
    }

    func courseItems(in univTimeTable: UnivTimeTable) -> [Univ_TimeTable.Lecture] {
        return PoolTimeTableModel.shared.pooledLectures.map { $0.toUnivLecture() }
    }
}
