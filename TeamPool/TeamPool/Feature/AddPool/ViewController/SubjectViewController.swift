//
//  SubjectViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation

final class SubjectViewController: BaseUIViewController {

    // MARK: - Data

    // MARK: - UI Components
    private let subjectView = SubjectView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(subjectView)
    }

    override func setLayout() {
        subjectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Action Method

    override func addTarget() {
        subjectView.nextButton.addTarget(self, action: #selector(didTappedNextButton), for: .touchUpInside)

    }

    @objc
    func didTappedNextButton() {
        let createPoolVC = CreatPoolViewController()
        self.navigationController?.pushViewController(createPoolVC, animated: true)
    }
}


