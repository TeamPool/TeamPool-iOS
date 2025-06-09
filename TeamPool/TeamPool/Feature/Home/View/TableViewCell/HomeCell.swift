//
//  PoolCell.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit
import SnapKit

class HomeCell: BaseTableViewCell {

    // MARK: - Properties
    static let identifier = "HomeCell"

    // MARK: - UI Components

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        return view
    }()

    private let teamImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.teamIcon
        return image
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let bookmarkImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.bookMark
        return image
    }()

    private let subNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private let checkImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.check
        return image
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    private let participantLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    private let dDayView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.layer.cornerRadius = 8
        return view
    }()

    private let dDayLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    // MARK: - Custom Method

    override func setUI() {
        contentView.addSubview(containerView)
        containerView.addSubviews(teamImage, nameLabel, dDayView, bookmarkImage, subNameLabel, checkImage, dateLabel, locationLabel, participantLabel)
        dDayView.addSubview(dDayLabel)
    }

    override func setLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }

        teamImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(20)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(teamImage.snp.trailing).offset(8)
            $0.centerY.equalTo(teamImage)
        }

        dDayView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalTo(teamImage)
            $0.width.equalTo(58)
            $0.height.equalTo(24)
        }

        dDayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        bookmarkImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(teamImage.snp.bottom).offset(12)
            $0.width.equalTo(14)
            $0.height.equalTo(17)
        }

        subNameLabel.snp.makeConstraints {
            $0.leading.equalTo(bookmarkImage.snp.trailing).offset(8)
            $0.centerY.equalTo(bookmarkImage)
        }

        checkImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(bookmarkImage.snp.bottom).offset(12)
            $0.size.equalTo(16)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(checkImage.snp.trailing).offset(8)
            $0.centerY.equalTo(checkImage)
        }
        
        participantLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(16)
        }
    }

    // MARK: - Configure

    func configure(with model: HomeModel) {
        nameLabel.text = model.name
        subNameLabel.text = model.subName
        dateLabel.text = model.date
        participantLabel.text = model.participant
        dDayLabel.text = model.dDay
    }
}
