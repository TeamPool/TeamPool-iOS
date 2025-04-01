//
//  UsaintLogInView.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit

import SnapKit

class UsaintLogInView: BaseUIView {

    // MARK: - UI Components

    lazy var idTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "학번"
        textField.addLeftImage(image: ImageLiterals.logInPerson)
        return textField
    }()

    lazy var pwTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "비밀번호"
        textField.addLeftImage(image: ImageLiterals.logInLock)
        return textField
    }()

    lazy var signInButton: BaseFillButton = {
        let button = BaseFillButton()
        button.setTitle("Log In", for: .normal)
        button.isEnabled = true
        return button
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Method

    override func setUI() {
        self.addSubviews(idTextField,
                         pwTextField,
                         signInButton)

    }

    override func setLayout() {
        idTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
            $0.height.equalTo(50)
        }

        pwTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.height.equalTo(50)
        }

        signInButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(pwTextField.snp.bottom).offset(20)
            $0.height.equalTo(50)
        }
    }
}


