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

    private let authService = AuthService() 

    // MARK: - UI Components

    private let signUpView = SignUpView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        handleIdValidation(isValid: true)
        handleNicknameValidation(isValid: true)
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

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "회원가입 실패", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
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
        guard let studentNumber = signUpView.idTextField.text,
              let nickname = signUpView.nicknameTextField.text,
              let password = signUpView.pwTextField.text,
              !studentNumber.isEmpty,
              !nickname.isEmpty,
              !password.isEmpty else {
            showAlert("모든 필드를 입력해주세요.")
            return
        }

        let requestDTO = SignUpRequestDTO(studentNumber: studentNumber, nickname: nickname, password: password)

        authService.signUp(requestDTO: requestDTO) { [weak self] result in
            switch result {
            case .success(let message):
                print("✅ 회원가입 성공:", message)
                DispatchQueue.main.async {
                    self?.navigationController?.popToRootViewController(animated: true)
                }

            case .requestErr(let message):
                print("❌ 회원가입 실패:", message)

                DispatchQueue.main.async {
                    if message.contains("학번") {
                        self?.handleIdValidation(isValid: false)
                    }
                    if message.contains("닉네임") {
                        self?.handleNicknameValidation(isValid: false)
                    }
                    self?.showAlert(message)
                }

            case .pathErr:
                self?.showAlert("응답을 처리할 수 없습니다.")

            case .serverErr:
                self?.showAlert("서버 오류가 발생했습니다.")

            case .networkFail:
                self?.showAlert("네트워크 연결에 실패했습니다.")
            }
        }
    }
}
