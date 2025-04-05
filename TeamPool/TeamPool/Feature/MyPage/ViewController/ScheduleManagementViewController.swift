//
//  MyPageViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation


final class ScheduleManagementViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let scheduleManagementView = ScheduleManagementView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "시간표 관리"
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(scheduleManagementView)
    }

    override func setLayout() {
        scheduleManagementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
