//
//  FindPeopleView.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit
import SnapKit

final class FindPeopleView: BaseUIView {

    // MARK: - UI Components

    private let stepIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.step2
        return imageView
    }()

    private let personNameLabel: UILabel = {
        let label = UILabel()
        label.text = "팀원을 선택해주세요"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FindPeopleCell.self, forCellReuseIdentifier: FindPeopleCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
        tableView.rowHeight = 50 // 사람 셀 높이 기준
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
        button.backgroundColor = UIColor(hex: 0x89A4C7)
        button.setTitleColor(.white, for: .normal)
        return button
    }()


    let nextButton: BaseFillButton = {
        let button = BaseFillButton()
        button.addTitleAttribute(title: "다음", titleColor: .white, fontName: .systemFont(ofSize: 16, weight: .bold))
        button.isEnabled = true
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


    // MARK: - Setup
    override func setUI() {
        self.addSubviews(stepIndicatorImageView,
                         personNameLabel,
                         tableView,
                         searchBar,
                         searchButton,
                         nextButton)
        self.addSubview(friendListHeaderView)
        friendListHeaderView.addSubview(friendListLabel)
    }

    override func setLayout() {
        stepIndicatorImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }

        personNameLabel.snp.makeConstraints {
            $0.top.equalTo(stepIndicatorImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
        }

        searchBar.snp.makeConstraints {
            $0.top.equalTo(personNameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(15)
            $0.width.equalTo(300)
            $0.height.equalTo(34)
        }

        searchButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.top)
            $0.height.equalTo(searchBar)
            $0.width.equalTo(60)
            $0.leading.equalTo(searchBar.snp.trailing).offset(10)
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

        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
    }
}
