//
//  HomeViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation

final class HomeViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let homeView = HomeView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Custom Method

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "Pool"
    }

    override func setUI() {
        view.addSubview(homeView)
    }

    override func setLayout() {
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Action Method

    override func addTarget() {
        homeView.exampleButton.addTarget(self, action: #selector(didTappedExampleButton), for: .touchUpInside)

    }

    @objc
    func didTappedExampleButton() {
        print("홈버튼 클릭")
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}


