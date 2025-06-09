//
//  PoolCell.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit
import SnapKit

class HomeCell: BaseTableViewCell {

    static let identifier = "HomeCell"

    // MARK: - UI Components

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        return view
    }()

    private let teamIcon = UIImageView(image: ImageLiterals.teamIcon)
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()

    private let bookmarkIcon = UIImageView(image: ImageLiterals.bookMark)
    private let subNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()

    private let dateIcon = UIImageView(image: ImageLiterals.check)
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private let participantLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private let dDayLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "D-9"
        return label
    }()

    private let dDayView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.layer.cornerRadius = 12
        return view
    }()

    // MARK: - SetUI & Layout

    override func setUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)

        [teamIcon, nameLabel, bookmarkIcon, subNameLabel,
         dateIcon, dateLabel, participantLabel,
         dDayView].forEach { containerView.addSubview($0) }

        dDayView.addSubview(dDayLabel)
    }

    override func setLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }

        teamIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(20)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(teamIcon.snp.trailing).offset(8)
            $0.centerY.equalTo(teamIcon)
        }

        bookmarkIcon.snp.makeConstraints {
            $0.leading.equalTo(teamIcon)
            $0.top.equalTo(teamIcon.snp.bottom).offset(16)
            $0.size.equalTo(CGSize(width: 16, height: 16))
        }

        subNameLabel.snp.makeConstraints {
            $0.leading.equalTo(bookmarkIcon.snp.trailing).offset(8)
            $0.centerY.equalTo(bookmarkIcon)
        }

        dateIcon.snp.makeConstraints {
            $0.leading.equalTo(bookmarkIcon)
            $0.top.equalTo(bookmarkIcon.snp.bottom).offset(12)
            $0.size.equalTo(16)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(dateIcon.snp.trailing).offset(8)
            $0.centerY.equalTo(dateIcon)
        }

        participantLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel)
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(20)
        }

        dDayView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
            $0.width.greaterThanOrEqualTo(50)
        }

        dDayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
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
