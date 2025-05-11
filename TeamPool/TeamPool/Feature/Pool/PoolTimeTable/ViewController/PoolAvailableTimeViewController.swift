//
//  PoolAvailableTimeViewController.swift
//  TeamPool
//
//  Created by 성현주 on 5/7/25.
//

import Foundation

final class PoolAvailableTimeViewController: BaseUIViewController {

    // MARK: - Data

    // MARK: - UI Components
    private let poolAvailableTimeView = PoolAvailableTimeView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(poolAvailableTimeView)
    }

    override func setLayout() {
        poolAvailableTimeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Action Method

    override func addTarget() {
        poolAvailableTimeView.nextButton.addTarget(self, action: #selector(didTappedNextButton), for: .touchUpInside)

    }

    @objc
    func didTappedNextButton() {
        let findPeopleVC = FindPeopleViewController()
        self.navigationController?.pushViewController(findPeopleVC, animated: true)
    }

}

