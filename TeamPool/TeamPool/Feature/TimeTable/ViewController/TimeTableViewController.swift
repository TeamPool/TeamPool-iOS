//
//  TimeTableViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation
import Rusaint
import Univ_TimeTable

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
