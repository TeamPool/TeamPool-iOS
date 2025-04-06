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
        self.addSubviews(tableView)
        
    }
    
    
    override func setLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
