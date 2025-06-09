//
//  SplashViewController.swift
//  TeamPool
//
//  Created by 성현주 on 6/10/25.
//

import UIKit
final class SplashViewController: UIViewController {

    private let logoImageView = UIImageView(image: UIImage(named: "splash_logo"))
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBlue
        setupUI()
        goToMainAfterDelay()
    }

    private func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func goToMainAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let mainVC = BaseTabBarController()
            let window = UIApplication.shared.windows.first
            window?.rootViewController = mainVC
            window?.makeKeyAndVisible()
        }
    }
}
