//
//  SignUpView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//


import UIKit
import SnapKit

final class SignUpView: BaseUIView {

    // MARK: - UI Components

    // 학번
    private let idTitleLabel = UILabel()
    let idTextField = BaseTextField()
    let idCheckButton = BaseFillButton()

    // 닉네임
    private let nicknameTitleLabel = UILabel()
    let nicknameTextField = BaseTextField()
    let nicknameCheckButton = BaseFillButton()

    // 비밀번호
    private let pwTitleLabel = UILabel()
    let pwTextField = BaseTextField()

    // 비밀번호 재확인
    private let checkPwTitleLabel = UILabel()
    let checkPwTextField = BaseTextField()

    // 회원가입 버튼
    let signUpButton = BaseFillButton()

    // 에러 처리
    let pwErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.text = "비밀번호가 일치하지 않습니다."
        label.isHidden = true
        return label
    }()

    let idErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()


    let nicknameErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Method

    override func setUI() {

        [idTitleLabel, nicknameTitleLabel, pwTitleLabel, checkPwTitleLabel].forEach {
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = .darkGray
        }
        [idTextField, nicknameTextField, pwTextField, checkPwTextField].forEach {
            $0.addLeftPadding(width: 10)
        }

        [idCheckButton, nicknameCheckButton].forEach {
            $0.setTitle("중복 확인", for: .normal)
        }

        //라벨 타이틀
        idTitleLabel.text = "학번"
        nicknameTitleLabel.text = "닉네임"
        pwTitleLabel.text = "비밀번호"
        checkPwTitleLabel.text = "비밀번호 재확인"

        //Placeholder
        idTextField.placeholder = "Ex ) 20XXXXXXX"
        nicknameTextField.placeholder = "닉네임 최소 2자 - 최대 8자"
        pwTextField.placeholder = "비밀번호를 입력하세요."
        pwTextField.addLeftImage(image: ImageLiterals.logInLock)
        checkPwTextField.placeholder = "비밀번호를 입력하세요."
        checkPwTextField.addLeftImage(image: ImageLiterals.logInLock)

        checkPwTextField.isSecureTextEntry = true
        pwTextField.isSecureTextEntry = true



        //버튼
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.isEnabled = true

        //Add
        [idTitleLabel, nicknameTitleLabel, pwTitleLabel, checkPwTitleLabel,
         idTextField, idCheckButton, pwErrorLabel,idErrorLabel,
         nicknameTextField, nicknameCheckButton,nicknameErrorLabel,
         pwTextField, checkPwTextField,
         signUpButton].forEach { addSubview($0) }
    }

    override func setLayout() {

        // 학번
        idTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().inset(29)
        }

        idTextField.snp.makeConstraints {
            $0.top.equalTo(idTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(29)
            $0.height.equalTo(52)
        }

        idCheckButton.snp.makeConstraints {
            $0.centerY.equalTo(idTextField)
            $0.leading.equalTo(idTextField.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(29)
            $0.width.equalTo(80)
            $0.height.equalTo(52)
        }

        // 닉네임
        nicknameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(24)
            $0.leading.equalTo(idTitleLabel)
        }

        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(idTextField)
            $0.height.equalTo(52)
        }

        nicknameCheckButton.snp.makeConstraints {
            $0.centerY.equalTo(nicknameTextField)
            $0.leading.equalTo(nicknameTextField.snp.trailing).offset(8)
            $0.trailing.equalTo(idCheckButton)
            $0.width.equalTo(80)
            $0.height.equalTo(52)
        }

        // 비밀번호
        pwTitleLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(24)
            $0.leading.equalTo(idTitleLabel)
        }

        pwTextField.snp.makeConstraints {
            $0.top.equalTo(pwTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.height.equalTo(52)
        }

        // 비밀번호 재확인
        checkPwTitleLabel.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(24)
            $0.leading.equalTo(idTitleLabel)
        }

        checkPwTextField.snp.makeConstraints {
            $0.top.equalTo(checkPwTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.height.equalTo(52)
        }

        // 회원가입 버튼
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(checkPwTextField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.height.equalTo(52)
        }

        // 에러메시지
        pwErrorLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.centerY.equalTo(checkPwTitleLabel)
        }

        idErrorLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.centerY.equalTo(idTitleLabel)
        }

        nicknameErrorLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.centerY.equalTo(nicknameTitleLabel)
        }
    }
}
