//
//  SignInView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit

import SnapKit

class SignInView: BaseUIView {

    // MARK: - UI Components

    lazy var idTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "학번"
        textField.addLeftImage(image: ImageLiterals.logInPerson)
        return textField
    }()

    lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        textField.addLeftImage(image: ImageLiterals.logInLock)
        return textField
    }()

    lazy var signInButton: BaseFillButton = {
        let button = BaseFillButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .poolBlue2
        button.isEnabled = true
        return button
    }()

    lazy var signUpButton: BaseEmptyButton = {
        let button = BaseEmptyButton()
        button.setTitle("Sign Up", for: .normal)
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
                         passwordTextField,
                         signInButton,
                         signUpButton)

    }

    override func setLayout() {
        idTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.top.equalToSuperview().offset(350)
            $0.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.height.equalTo(50)
        }

        signInButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(100)
            $0.height.equalTo(50)
        }

        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(signInButton.snp.bottom).offset(20)
            $0.height.equalTo(50)
        }
    }
}

