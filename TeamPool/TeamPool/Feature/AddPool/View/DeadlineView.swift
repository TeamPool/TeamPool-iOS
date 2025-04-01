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
        label.text = "프로젝트 주제를 입력해주세요."
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    let subjectTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "주제"
        textField.addLeftPadding(width: 15)
        textField.setRoundBorder()
        return textField
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
                         subjectNameLabel,
                         subjectTextField,
                         nextButton)
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

        subjectTextField.snp.makeConstraints {
            $0.top.equalTo(subjectNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }



        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
    }
}

