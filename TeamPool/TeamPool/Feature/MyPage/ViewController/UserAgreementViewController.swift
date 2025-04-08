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

}
