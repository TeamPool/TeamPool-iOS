//
//  SignInViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import Foundation

final class SignInViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let signInView = SignInView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(signInView)
    }

    override func setLayout() {
        signInView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}




