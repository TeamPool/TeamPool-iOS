//
//  SignUpViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import Foundation
import UIKit

final class SignUpViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let signUpView = SignUpView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        handleIdValidation(isValid: true)
        handleNicknameValidation(isValid: false)
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(signUpView)
    }

    override func setLayout() {
        signUpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func handleIdValidation(isValid: Bool) {
        signUpView.idErrorLabel.isHidden = false
        signUpView.idErrorLabel.text = isValid ? "사용 가능한 학번입니다." : "이미 사용중인 학번입니다."
        signUpView.idErrorLabel.textColor = isValid ? .systemBlue : .systemRed
    }

    private func handleNicknameValidation(isValid: Bool) {
        signUpView.nicknameErrorLabel.isHidden = false
        signUpView.nicknameErrorLabel.text = isValid ? "사용 가능한 닉네임입니다." : "이미 사용중인 닉네임입니다."
        signUpView.nicknameErrorLabel.textColor = isValid ? .systemBlue : .systemRed
    }

    // MARK: - Action Method

    override func addTarget() {
        signUpView.pwTextField.addTarget(self, action: #selector(passwordCheck), for: .editingChanged)
        signUpView.checkPwTextField.addTarget(self, action: #selector(passwordCheck), for: .editingChanged)
        signUpView.signUpButton.addTarget(self, action: #selector(didTappedSignUpButton), for: .touchUpInside)
    }

    @objc
    private func passwordCheck() {
        let pw = signUpView.pwTextField.text ?? ""
        let checkPw = signUpView.checkPwTextField.text ?? ""
        signUpView.pwErrorLabel.isHidden = (checkPw.isEmpty || pw == checkPw)
    }

    @objc
    func didTappedSignUpButton() {
        print("회원가입 완료")
        navigationController?.popToRootViewController(animated: true)

    }

}




