//
//  FriendManagementView.swift
//  TeamPool
//
//  Created by Mac on 4/2/25.
//

import UIKit

import SnapKit

class FriendManagementView: BaseUIView {

    // MARK: - UI Components
    lazy var tableView: UITableView = {
       let tableView = UITableView()
       tableView.register(FriendManagementCell.self, forCellReuseIdentifier: "FriendManagementCell")
       tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
       tableView.rowHeight = 50
       return tableView
   }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "학번 검색"
        searchBar.setImage(ImageLiterals.SearchIcon, for: .search, state: .normal)
        searchBar.backgroundImage = UIImage() 
        searchBar.searchTextField.backgroundColor = UIColor(hex: 0xEFF5FF)
        searchBar.searchTextField.layer.cornerRadius = 8
        searchBar.searchTextField.clipsToBounds = true

        return searchBar
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("검색", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(hex : 0x89A4C7)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let friendListHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xEFF5FF) // 연한 파란색
        return view
    }()

    private let friendListLabel: UILabel = {
        let label = UILabel()
        label.text = "친구목록"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
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
        self.addSubview(tableView)
        self.addSubview(searchBar)
        self.addSubview(searchButton)
        self.addSubview(friendListHeaderView)
        friendListHeaderView.addSubview(friendListLabel)
    }
    
    
    override func setLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().inset(15)
            $0.width.equalTo(300)
            $0.height.equalTo(34)
        }
        
        friendListHeaderView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20) // 원하는 높이 조절
        }

        friendListLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview().offset(2)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(friendListHeaderView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.top)
            $0.height.equalTo(searchBar)
            $0.width.equalTo(60)
            $0.leading.equalTo(searchBar.snp.trailing).offset(10)
        }
    }
}
