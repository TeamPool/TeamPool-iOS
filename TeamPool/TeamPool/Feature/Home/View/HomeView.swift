//
//  HomeView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit

import SnapKit

class HomeView: BaseUIView {

    // MARK: - UI Components

    let tableView: UITableView = {
            let tableView = UITableView()
            tableView.separatorStyle = .none
            tableView.showsVerticalScrollIndicator = false
            tableView.register(PoolCell.self, forCellReuseIdentifier: "poolCell")
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
        self.addSubview(tableView)

    }

    override func setLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }

    }

}

