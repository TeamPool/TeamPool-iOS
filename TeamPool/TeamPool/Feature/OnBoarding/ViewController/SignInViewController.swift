//
//  SignInViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import Foundation
import UIKit

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
    // MARK: - Action Method

    override func addTarget() {
        signInView.signInButton.addTarget(self, action: #selector(didTappedSignInButton), for: .touchUpInside)

    }

    @objc
    func didTappedSignInButton() {
        print("로그인")
        let tabBarController = BaseTabBarController()
        UIApplication.shared.keyWindow?.replaceRootViewController(tabBarController, animated: true, completion: nil)

    }

}




