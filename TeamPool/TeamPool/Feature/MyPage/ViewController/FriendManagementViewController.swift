//
//  MyPageViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation


final class FriendManagementViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let friendManagementView = FriendManagementView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "친구 관리"
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(friendManagementView)
    }

    override func setLayout() {
        friendManagementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
