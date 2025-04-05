//
//  MyPageViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation


final class UserAgreementViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let userAgreementView = UserAgreementView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "이용 약관"
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(userAgreementView)
    }

    override func setLayout() {
        userAgreementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
