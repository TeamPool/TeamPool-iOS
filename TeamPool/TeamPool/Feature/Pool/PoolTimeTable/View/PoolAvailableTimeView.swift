//
//  PoolAvailableTimeView.swift
//  TeamPool
//
//  Created by 성현주 on 5/7/25.
//


import UIKit
import SnapKit

struct AvailableTimeModel {
    let day: String
    let times: [String]
}

final class PoolAvailableTimeView: BaseUIView {

    // MARK: - UI Components

    private let titleSection: UILabel = {
        let label = UILabel()
        label.text = "🧑‍🤝‍🧑Pool맴버가 모두 가능한 시간이에요!"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let dayStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    // MARK: - Setup

    override func setUI() {
        addSubviews(titleSection, dayStackView)
    }

    override func setLayout() {
        titleSection.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        dayStackView.snp.makeConstraints {
            $0.top.equalTo(titleSection.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Public Method

    func configure(with models: [AvailableTimeModel]) {
        dayStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // 요일 정렬 기준
        let orderedDays = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
        let sortedModels = orderedDays.compactMap { day in
            models.first(where: { $0.day == day })
        }

        for (index, model) in sortedModels.enumerated() {
            let dayRow = makeDayRow(day: model.day, times: model.times)
            dayStackView.addArrangedSubview(dayRow)

            // 마지막 요소가 아니면 구분선 추가
            if index < sortedModels.count - 1 {
                let separator = makeSeparator()
                dayStackView.addArrangedSubview(separator)
            }
        }
    }

    private func makeSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = UIColor(hex: 0xE5E5E5)
        separator.snp.makeConstraints { $0.height.equalTo(1) }
        return separator
    }

    private func makeDayRow(day: String, times: [String]) -> UIView {
        let colorCircle = UIView()
        colorCircle.layer.cornerRadius = 6
        colorCircle.backgroundColor = times.isEmpty ? .lightGray : UIColor(hex: 0x4DD7FF)
        colorCircle.snp.makeConstraints { $0.size.equalTo(12) }

        let dayLabel = UILabel()
        dayLabel.text = day
        dayLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        dayLabel.textColor = .black

        let dayHeaderStack = UIStackView(arrangedSubviews: [colorCircle, dayLabel])
        dayHeaderStack.axis = .horizontal
        dayHeaderStack.spacing = 8
        dayHeaderStack.alignment = .center

        let timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.numberOfLines = 0
        timeLabel.textColor = times.isEmpty ? .lightGray : .black
        timeLabel.text = times.isEmpty ? "해당 요일에 되는 시간이 없습니다." : times.joined(separator: "\n")

        let contentStack = UIStackView(arrangedSubviews: [dayHeaderStack, timeLabel])
        contentStack.axis = .vertical
        contentStack.spacing = 4
        return contentStack
    }
}
