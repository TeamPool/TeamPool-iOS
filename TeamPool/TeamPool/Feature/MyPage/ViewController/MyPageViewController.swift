//
//  MyPageViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation

final class MyPageViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let myPageView = MyPageView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "MyPage"
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(myPageView)
    }

    override func setLayout() {
        myPageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}



