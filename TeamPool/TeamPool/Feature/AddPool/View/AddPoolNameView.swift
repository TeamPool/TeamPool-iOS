//
//  AddPoolView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit
import SnapKit

final class AddPoolNameView: BaseUIView {

    // MARK: - Data
    private var subjectList: [String] = []

    // MARK: - UI Components

    private let stepIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.step1
        return imageView
    }()

    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "팀명을 입력해주세요"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    let teamNameTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "최대 15자"
        textField.addLeftPadding(width: 15)
        textField.setRoundBorder()
        return textField
    }()

    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "과목을 선택해주세요"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    let subjectSelectTextField: BaseTextField = {
        let textField = BaseTextField()
        textField.placeholder = "과목을 선택해주세요"
        textField.addLeftPadding(width: 15)
        textField.setRoundBorder()
        textField.clearButtonMode = .never
        textField.isUserInteractionEnabled = true
        return textField
    }()

    private let subjectSelectButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.down")
        config.imagePlacement = .trailing
        config.contentInsets = .zero

        let button = UIButton(configuration: config)
        button.showsMenuAsPrimaryAction = true
        button.tintColor = .gray
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
                         teamNameLabel,
                         teamNameTextField,
                         subjectLabel,
                         subjectSelectTextField,
                         subjectSelectButton,
                         nextButton)
    }

    override func setLayout() {
        stepIndicatorImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(30)
        }

        teamNameLabel.snp.makeConstraints {
            $0.top.equalTo(stepIndicatorImageView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(24)
        }

        teamNameTextField.snp.makeConstraints {
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }

        subjectLabel.snp.makeConstraints {
            $0.top.equalTo(teamNameTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
        }

        subjectSelectTextField.snp.makeConstraints {
            $0.top.equalTo(subjectLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(44)
        }

        subjectSelectButton.snp.makeConstraints {
            $0.centerY.equalTo(subjectSelectTextField)
            $0.trailing.equalTo(subjectSelectTextField).inset(12)
            $0.width.height.equalTo(24)
        }


        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
    }

    // MARK: - Public Function
    func configureSubjectList(_ subjects: [String]) {
        self.subjectList = subjects
        let actions = subjects.map { subject in
            UIAction(title: subject) { [weak self] _ in
                self?.subjectSelectTextField.text = subject
            }
        }
        subjectSelectButton.menu = UIMenu(children: actions)
    }
}
