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

final class PoolTimeTableViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let poolTimeTableView = PoolTimeTableView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        PoolTimeTableModel.shared.mockData()
        addDelegate()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(poolTimeTableView)
    }

    override func setLayout() {
        poolTimeTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addDelegate(){
        poolTimeTableView.timeTable.dataSource = self
    }
    // MARK: - Action Method

    override func addTarget() {
    }

    @objc
    func didTappedCallTimeTableButton() {
        print("dddddd")
        self.dismiss(animated: true)
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
