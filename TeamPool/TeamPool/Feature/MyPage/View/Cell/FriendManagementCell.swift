//
//  FriendManagementCell.swift
//  TeamPool
//
//  Created by Mac on 4/6/25.
//

import Foundation
import UIKit
import SnapKit

class FriendManagementCell: UITableViewCell {

    static let identifier = "FriendManagementCell"

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.mypageProfile
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hex: 0x8B8B8B)
        return label
    }()

    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("삭제", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: 0x89A4C7)
        button.layer.cornerRadius = 8
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(deleteButton)
    }

    private func setupLayout() {
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
            $0.top.equalTo(profileImageView.snp.top)
        }

        numberLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
        }

        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(20)
        }
    }

    func configure(with model: FindPeopleModel, isSearchResult: Bool) {
        nameLabel.text = model.name
        numberLabel.text = model.studentNumber

        let title = isSearchResult ? "추가" : "삭제"
        deleteButton.setTitle(title, for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
    }
}

