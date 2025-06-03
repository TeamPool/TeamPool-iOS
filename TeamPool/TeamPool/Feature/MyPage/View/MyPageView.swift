//
//  MyPageView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit
import SnapKit

final class MyPageView: BaseUIView {

    // MARK: - UI Components

    lazy var pageLabel: UILabel = {
        let label = UILabel()
        label.text = "My Page"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    // 닉네임/학번을 외부에서 설정할 수 있게 만듦
    let nameLabel = UILabel()
    let studentNumberLabel = UILabel()

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.mypageProfile
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var profileContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(studentNumberLabel)

        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }

        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
            $0.top.equalTo(profileImageView.snp.top)
        }

        studentNumberLabel.font = .systemFont(ofSize: 16)
        studentNumberLabel.textColor = .gray
        studentNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.bottom.equalTo(profileImageView.snp.bottom)
        }

        return view
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingCell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
        tableView.rowHeight = 50
        tableView.separatorInset = .zero
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
        addSubview(pageLabel)
        addSubview(profileContainerView)
        addSubview(tableView)
    }

    override func setLayout() {
        pageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(80)
        }

        profileContainerView.snp.makeConstraints {
            $0.top.equalTo(pageLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(90)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
