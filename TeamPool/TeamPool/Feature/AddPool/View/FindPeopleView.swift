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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    let personNameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "이름, 학번 검색"
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
                         personNameLabel,
                         personNameTextField,
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

        personNameTextField.snp.makeConstraints {
            $0.top.equalTo(personNameLabel.snp.bottom).offset(8)
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
