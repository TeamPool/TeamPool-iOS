//
//  CalendarViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation

final class CalendarViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let calendarView = CalendarView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar"
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

}


