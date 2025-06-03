//
//  MyPageView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit
import SnapKit

class AccountManagementView: BaseUIView {
    
    // MARK: - UI Components
    lazy var nicknameLabel : UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var duplicateCheckButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("중복 확인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(hex : 0xCACACA)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("수정", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(hex: 0xCACACA)
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    lazy var LogouttableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LogoutCell.self, forCellReuseIdentifier: "LogoutCell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor(hex : 0xEFF5FF)
        tableView.rowHeight = 60
        return tableView
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor(hex: 0xFF8282)
        return label
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
        self.addSubview(LogouttableView)
        self.addSubview(nicknameLabel)
        self.addSubview(nicknameTextField)
        self.addSubview(updateButton)
        self.addSubview(duplicateCheckButton)
        self.addSubview(errorLabel)
    }
    
    
    override func setLayout() {
        nicknameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(140)
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo(220)
            $0.height.equalTo(50)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.bottom.equalTo(nicknameTextField.snp.top)
            $0.left.equalTo(nicknameTextField.snp.left)
        }
        
        duplicateCheckButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.top)
            $0.width.equalTo(80)
            $0.height.equalTo(50)
            $0.left.equalTo(nicknameTextField.snp.right).offset(15)
        }
        
        updateButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            $0.left.equalTo(nicknameTextField.snp.left)
            $0.width.equalTo(315)
            $0.height.equalTo(50)
        }
        LogouttableView.snp.makeConstraints {
            $0.top.equalTo(updateButton.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints {
            $0.trailing.equalTo(duplicateCheckButton.snp.trailing).offset(-1)
            $0.bottom.equalTo(duplicateCheckButton.snp.top).offset(-3)
        }
    }
}

    

