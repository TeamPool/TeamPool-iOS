//
//  DeadlineView.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit
import SnapKit

final class DeadlineView: BaseUIView {

    // MARK: - UI Components

    private let stepIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.step3
        return imageView
    }()

    private let subjectNameLabel: UILabel = {
        let label = UILabel()
        label.text = "프로젝트 마감일을 선택해주세요."
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()


    // hex 익스텐션 추가해놓기
    private let calendarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#F8FAFC")
        view.layer.masksToBounds = true
        return view
    }()

    let calendarPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.locale = Locale(identifier: "ko_KR")
        picker.backgroundColor = .white
        picker.layer.cornerRadius = 9
        return picker
    }()

    let nextButton: BaseFillButton = {
        let button = BaseFillButton()
        button.addTitleAttribute(title: "다음", titleColor: .white, fontName: .systemFont(ofSize: 16, weight: .bold))
        button.isEnabled = true
        return button
    }()

    // MARK: - Setup
    override func setUI() {
        addSubviews(
            stepIndicatorImageView,
            subjectNameLabel,
            calendarBackgroundView,
            nextButton
        )
        calendarBackgroundView.addSubview(calendarPicker)
    }

    override func setLayout() {
        stepIndicatorImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }

        subjectNameLabel.snp.makeConstraints {
            $0.top.equalTo(stepIndicatorImageView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(24)
        }

        calendarBackgroundView.snp.makeConstraints {
            $0.top.equalTo(subjectNameLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(395)
        }

        calendarPicker.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
    }
}
