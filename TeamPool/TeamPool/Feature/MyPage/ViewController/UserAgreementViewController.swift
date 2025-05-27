//
//  MyPageViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation
import UIKit

final class UserAgreementViewController: BaseUIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let userAgreementView = UserAgreementView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCustomBackButton()
    }
    
    // MARK: - Custom Method
    
    override func setUI() {
        view.backgroundColor = UIColor(hex : 0xEFF5FF)
        view.addSubview(userAgreementView)
    }
    
    override func setLayout() {
        userAgreementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - 커스텀 백버튼

    private func configureCustomBackButton() {
        let backButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        backButton.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        backButton.setTitle(" 이용 약관", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        let backItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backItem
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
