//
//  AccountManagementViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import UIKit

final class AccountManagementViewController: BaseUIViewController {

    // MARK: - UI Components

    private let accountManagementView = AccountManagementView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureCustomBackButton() // ✅ 커스텀 백버튼
        accountManagementView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
        accountManagementView.duplicateCheckButton.addTarget(self, action: #selector(duplicateCheckButtonTapped), for: .touchUpInside)
    }

    // MARK: - UI 구성

    override func setUI() {
        view.backgroundColor = UIColor(hex: 0xEFF5FF)
        view.addSubview(accountManagementView)
    }

    override func setLayout() {
        accountManagementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupTableView() {
        accountManagementView.LogouttableView.delegate = self
        accountManagementView.LogouttableView.dataSource = self
        accountManagementView.LogouttableView.register(LogoutCell.self, forCellReuseIdentifier: LogoutCell.identifier)
        accountManagementView.LogouttableView.register(WithdrawalCell.self, forCellReuseIdentifier: WithdrawalCell.identifier)
    }

    // MARK: - 닉네임 입력 처리

    @objc private func nicknameTextFieldDidChange() {
        guard let text = accountManagementView.nicknameTextField.text else { return }

        if text.count >= 2 && text.count <= 8 {
            accountManagementView.errorLabel.text = ""
            accountManagementView.duplicateCheckButton.backgroundColor = UIColor(hex: 0x89A4C7)
            accountManagementView.duplicateCheckButton.isEnabled = true
        } else {
            if text.count != 0 {
                accountManagementView.errorLabel.text = "닉네임의 형식이 올바르지 않습니다."
            }
            accountManagementView.duplicateCheckButton.backgroundColor = UIColor(hex: 0xCACACA)
            accountManagementView.duplicateCheckButton.isEnabled = false
        }
    }

    @objc private func duplicateCheckButtonTapped() {
        accountManagementView.errorLabel.text = "사용 가능한 닉네임입니다."
        updateUpdateButtonState()
    }

    private func updateUpdateButtonState() {
        accountManagementView.updateButton.backgroundColor = UIColor(hex: 0x89A4C7)
        accountManagementView.updateButton.isEnabled = true
    }

    // MARK: - 커스텀 백버튼

    private func configureCustomBackButton() {
        let backButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        backButton.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        backButton.setTitle(" 계정 관리", for: .normal)
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

// MARK: - 테이블뷰

extension AccountManagementViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LogoutCell.identifier, for: indexPath) as? LogoutCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = UIColor(hex: 0xEFF5FF)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WithdrawalCell.identifier, for: indexPath) as? WithdrawalCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = UIColor(hex: 0xEFF5FF)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let message1: String
        let message2: String

        if indexPath.row == 0 {
            message1 = "로그아웃하시겠습니까?"
            message2 = "로그아웃"
        } else {
            message1 = "계정을 탈퇴하시겠습니까?"
            message2 = "탈퇴"
        }

        let alertController = UIAlertController(title: nil, message: message1, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: message2, style: .default) { _ in
            // TODO: 로그아웃 / 탈퇴 로직 구현
        }

        let cancelAction = UIAlertAction(title: "취소", style: .default)

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
    

        present(alertController, animated: true)
    }
}

