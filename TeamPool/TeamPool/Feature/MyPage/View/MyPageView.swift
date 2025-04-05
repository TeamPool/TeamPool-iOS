//
//  MyPageView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit

import SnapKit

class MyPageView: BaseUIView {

    // MARK: - UI Components
    
    lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.text = "My Page"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    lazy var profileContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        
        let profileImageView = UIImageView()
        profileImageView.image = ImageLiterals.mypageProfile
        profileImageView.contentMode = .scaleAspectFit
        
        let nameLabel = UILabel()
        nameLabel.text = "다이나믹한삼고양이"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        
        let phoneLabel = UILabel()
        phoneLabel.text = "20XXXXXX"
        phoneLabel.font = UIFont.systemFont(ofSize: 16)
        phoneLabel.textColor = .gray
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(phoneLabel)
        
        profileImageView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(15)
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(50)
            }
            
            nameLabel.snp.makeConstraints {
                $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
                $0.top.equalTo(profileImageView.snp.top)
            }
            
            phoneLabel.snp.makeConstraints {
                $0.leading.equalTo(nameLabel)
                $0.bottom.equalTo(profileImageView.snp.bottom)
            }
        return view
    }()
    
     lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingCell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor(hex : 0xEFF5FF)
        tableView.rowHeight = 50
        return tableView
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
        self.addSubview(pageLabel)
        self.addSubview(profileContainerView)
        self.addSubview(tableView)
        
    }
    
    override func setLayout() {
        pageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(80)
        }
        profileContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(125)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
            }
        tableView.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom).offset(20)  // circleView 아래로 30 간격
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: -UIColor -> 곧 없어질 예정
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

