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

    private var isIdValid = false
    private var isNicknameValid = false
    private var isPasswordMatched = false {
        didSet { updateSignUpButtonState() }
    }

    // MARK: - UI Components

    private let signUpView = SignUpView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        handleIdValidation(isValid: true)
        handleNicknameValidation(isValid: true)
        updateSignUpButtonState()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(signUpView)
    }

    override func setLayout() {
        signUpView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    private func handleIdValidation(isValid: Bool) {
        isIdValid = isValid
        signUpView.idErrorLabel.isHidden = false
        signUpView.idErrorLabel.text = isValid ? "사용 가능한 학번입니다." : "이미 사용중인 학번입니다."
        signUpView.idErrorLabel.textColor = isValid ? .systemBlue : .systemRed
        updateSignUpButtonState()
    }

    private func handleNicknameValidation(isValid: Bool) {
        isNicknameValid = isValid
        signUpView.nicknameErrorLabel.isHidden = false
        signUpView.nicknameErrorLabel.text = isValid ? "사용 가능한 닉네임입니다." : "이미 사용중인 닉네임입니다."
        signUpView.nicknameErrorLabel.textColor = isValid ? .systemBlue : .systemRed
        updateSignUpButtonState()
    }

    private func updateSignUpButtonState() {
        let allFieldsFilled = !(signUpView.idTextField.text?.isEmpty ?? true)
            && !(signUpView.nicknameTextField.text?.isEmpty ?? true)
            && !(signUpView.pwTextField.text?.isEmpty ?? true)
            && !(signUpView.checkPwTextField.text?.isEmpty ?? true)

        signUpView.signUpButton.isEnabled = allFieldsFilled && isIdValid && isNicknameValid && isPasswordMatched
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
        signUpView.idCheckButton.addTarget(self, action: #selector(didTapIdCheck), for: .touchUpInside)
        signUpView.nicknameCheckButton.addTarget(self, action: #selector(didTapNicknameCheck), for: .touchUpInside)
    }

    @objc
    private func passwordCheck() {
        let pw = signUpView.pwTextField.text ?? ""
        let checkPw = signUpView.checkPwTextField.text ?? ""
        let isMatch = !checkPw.isEmpty && pw == checkPw

        signUpView.pwErrorLabel.isHidden = isMatch
        isPasswordMatched = isMatch
    }

    @objc
    private func didTapIdCheck() {
        guard let studentNumber = signUpView.idTextField.text, !studentNumber.isEmpty else {
            handleIdValidation(isValid: false)
            signUpView.idErrorLabel.text = "학번을 입력해주세요."
            return
        }

        authService.checkStudentNumberDup(studentNumber) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.handleIdValidation(isValid: true)
                case .requestErr(let message):
                    self?.handleIdValidation(isValid: false)
                    self?.signUpView.idErrorLabel.text = message
                default:
                    self?.handleIdValidation(isValid: false)
                    self?.signUpView.idErrorLabel.text = "확인 중 오류가 발생했습니다."
                }
            }
        }
    }

    @objc
    private func didTapNicknameCheck() {
        guard let nickname = signUpView.nicknameTextField.text, !nickname.isEmpty else {
            handleNicknameValidation(isValid: false)
            signUpView.nicknameErrorLabel.text = "닉네임을 입력해주세요."
            return
        }

        authService.checkNicknameDup(nickname) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.handleNicknameValidation(isValid: true)
                case .requestErr(let message):
                    self?.handleNicknameValidation(isValid: false)
                    self?.signUpView.nicknameErrorLabel.text = message
                default:
                    self?.handleNicknameValidation(isValid: false)
                    self?.signUpView.nicknameErrorLabel.text = "확인 중 오류가 발생했습니다."
                }
            }
        }
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
