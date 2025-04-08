//
//  MyPageViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation
import UIKit

final class AccountManagementViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let accountManagementView = AccountManagementView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        accountManagementView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
        accountManagementView.duplicateCheckButton.addTarget(self, action: #selector(duplicateCheckButtonTapped), for: .touchUpInside)
    }

    // MARK: - Custom Method

    override func setUI() {
        view.backgroundColor = UIColor(hex : 0xEFF5FF)
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
    
    @objc private func nicknameTextFieldDidChange() {
        // 텍스트 필드 값 가져오기
        guard let text = accountManagementView.nicknameTextField.text else { return }
        
        // 2자 이상, 8자 이하
            
        if text.count >= 2 && text.count <= 8 {
            // 버튼 활성화
            accountManagementView.errorLabel.text = ""
            accountManagementView.duplicateCheckButton.backgroundColor = UIColor(hex: 0x89A4C7)
            accountManagementView.duplicateCheckButton.isEnabled = true
        } else {
            // 버튼 비활성화
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
}

//MARK: - 테이블 뷰 정리

extension AccountManagementViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LogoutCell.identifier, for: indexPath) as? LogoutCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = UIColor(hex : 0xEFF5FF)
            return cell
        }
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WithdrawalCell.identifier, for: indexPath) as? WithdrawalCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = UIColor(hex : 0xEFF5FF)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var message1 : String = ""
        var message2 : String = ""
        if indexPath.row == 0 {
            message1 = "로그아웃하시겠습니까?"
            message2 = "로그아웃"
        }
        
        if indexPath.row == 1 {
            message1 = "계정을 탈퇴하시겠습니까?"
            message2 = "탈퇴"
        }
        
        // 경고창 띄우기
        let alertController = UIAlertController(title: nil, message: message1, preferredStyle: .alert)
        
        //왼쪽 버튼
        let logoutAction = UIAlertAction(title: message2, style: .default) { _ in
            if message1 == "로그아웃"{
                //로그아웃 여기 구현
            }
            
            else {
                //탈퇴 여기 구현
            }
        }
        
        //취소 누르는 경우
        let cancelAction = UIAlertAction(title: "취소", style: .default) { _ in
            
        }
        // 알림창에 버튼 추가
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        // 알림창 표시
        self.present(alertController, animated: true, completion: nil)
    }
}
