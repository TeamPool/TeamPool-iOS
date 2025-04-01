//
//  CreatPoolView.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit
import SnapKit

final class CreatPoolView: BaseUIView {

    // MARK: - UI Components

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "POOL 생성 완료!🏝️"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.alpha = 0
        return label
    }()

    let nextButton: BaseFillButton = {
        let button = BaseFillButton()
        button.addTitleAttribute(title: "확인", titleColor: .white, fontName: .systemFont(ofSize: 16, weight: .bold))
        button.alpha = 0
        button.isEnabled = true
        return button
    }()

    // MARK: - Setup
    override func setUI() {
        addSubviews(titleLabel, nextButton)
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(48)
        }
    }

    func startAnimation() {
        UIView.animate(withDuration: 0.8) {
            self.titleLabel.alpha = 1
        }

        UIView.animate(withDuration: 0.8, delay: 0.3, options: [], animations: {
            self.nextButton.alpha = 1
        }, completion: nil)
    }
}
