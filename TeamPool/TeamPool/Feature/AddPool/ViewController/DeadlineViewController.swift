//
//  DeadlineViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation

final class DeadlineViewController: BaseUIViewController {

    // MARK: - Data

    // MARK: - UI Components
    private let deadlineView = DeadlineView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(deadlineView)
    }

    override func setLayout() {
        deadlineView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Action Method

    override func addTarget() {
        deadlineView.nextButton.addTarget(self, action: #selector(didTappedNextButton), for: .touchUpInside)

    }

    @objc
    func didTappedNextButton() {
        let selectedDate = deadlineView.calendarPicker.date

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: selectedDate)

        PoolCreateDataStore.shared.deadline = formattedDate

        let subjectVC = SubjectViewController()
        self.navigationController?.pushViewController(subjectVC, animated: true)
    }


}

