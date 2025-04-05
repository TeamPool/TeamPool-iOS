//
//  MyPageViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation


final class AccountManagementViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let accountManagementView = AccountManagementView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "게정 관리"
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(accountManagementView)
    }

    override func setLayout() {
        accountManagementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
