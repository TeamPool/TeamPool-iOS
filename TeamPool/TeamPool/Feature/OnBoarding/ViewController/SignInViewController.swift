//
//  SignInViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import Foundation
import UIKit

final class SignInViewController: BaseUIViewController {

    // MARK: - Properties

    private let authService = AuthService()

    // MARK: - UI Components

    private let signInView = SignInView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(signInView)
    }

    override func setLayout() {
        signInView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Action Method

    override func addTarget() {
        signInView.signInButton.addTarget(self, action: #selector(didTappedSignInButton), for: .touchUpInside)
        signInView.signUpButton.addTarget(self, action: #selector(didTappedSignUpButton), for: .touchUpInside)
    }

    @objc
    func didTappedSignInButton() {
        guard let studentNumber = signInView.idTextField.text,
              let password = signInView.passwordTextField.text,
              !studentNumber.isEmpty, !password.isEmpty else {
            print("⚠️ 학번 또는 비밀번호가 비어있습니다.")
            return
        }

        let requestDTO = LoginRequestDTO(studentNumber: studentNumber, password: password)

        authService.login(requestDTO: requestDTO) { [weak self] result in
            switch result {
            case .success(let tokenDTO):
                print("✅ 로그인 성공")
                print("AccessToken:", tokenDTO.accessToken)
                print("RefreshToken:", tokenDTO.refreshToken)

                // 토큰 저장
                UserDefaults.standard.set(tokenDTO.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(tokenDTO.refreshToken, forKey: "refreshToken")

                // 루트 전환
                DispatchQueue.main.async {
                    let tabBarController = BaseTabBarController()
                    UIApplication.shared.keyWindow?.replaceRootViewController(tabBarController, animated: true, completion: nil)
                }

            case .requestErr(let message):
                print("❌ 요청 오류: \(message)")
                self?.showAlert(message: message)

            case .pathErr:
                print("❌ 디코딩 오류")
                self?.showAlert(message: "응답을 처리할 수 없습니다.")

            case .serverErr:
                print("❌ 서버 오류")
                self?.showAlert(message: "서버에서 문제가 발생했습니다.")

            case .networkFail:
                print("❌ 네트워크 오류")
                self?.showAlert(message: "네트워크 연결에 실패했습니다.")
            }
        }
    }

    @objc
    func didTappedSignUpButton() {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "로그인 실패", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
