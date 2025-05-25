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
        tableView.backgroundColor = UIColor(hex: 0xEFF5FF)
        tableView.rowHeight = 50 // 사람 셀 높이 기준
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "이름, 학번 검색"
        searchBar.setImage(ImageLiterals.SearchIcon, for: .search, state: .normal)
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 8
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

    // MARK: - Setup
    override func setUI() {
        self.addSubviews(stepIndicatorImageView,
                         personNameLabel,
                         tableView,
                         searchBar,
                         searchButton,
                         nextButton)
    }

    override func setLayout() {
        stepIndicatorImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }

        personNameLabel.snp.makeConstraints {
            $0.top.equalTo(stepIndicatorImageView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(24)
        }

        searchBar.snp.makeConstraints {
            $0.top.equalTo(personNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }

        searchButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.top)
            $0.height.equalTo(searchBar)
            $0.width.equalTo(60)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
    }
}
