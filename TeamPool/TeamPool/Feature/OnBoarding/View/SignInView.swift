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

    // TODO:-아이콘 변경
    lazy var idTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "학번"
        textField.addLeftImage(image: ImageLiterals.myPage)
        return textField
    }()

    lazy var passwordTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "비밀번호"
        textField.addLeftImage(image: ImageLiterals.myPage)
        return textField
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
        self.addSubviews(idTextField,passwordTextField)

    }

    override func setLayout() {
        idTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.center.equalToSuperview()
            $0.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(idTextField.snp.bottom).offset(12)
            $0.height.equalTo(50)
        }
    }
}

