//
//  FindPeopleViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation

final class FindPeopleViewController: BaseUIViewController {

    // MARK: - Data

    // MARK: - UI Components
    private let findPeopleView = FindPeopleView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(findPeopleView)
    }

    override func setLayout() {
        findPeopleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Action Method

    override func addTarget() {
        findPeopleView.nextButton.addTarget(self, action: #selector(didTappedNextButton), for: .touchUpInside)

    }

    @objc
    func didTappedNextButton() {
        let deadlineVC = DeadlineViewController()
        self.navigationController?.pushViewController(deadlineVC, animated: true)
    }
}
