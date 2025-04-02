//
//  BaseEmptyButton.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit

import SnapKit

class BaseEmptyButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            isEnabled ? setEnableButton() : setDisableButton()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEmptyButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupEmptyButton() {
        self.addTitleAttribute(title: "", titleColor: .poolBlue2, fontName: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!)
        self.setRoundBorder(borderColor: .poolBlue2, borderWidth: 1.0, cornerRadius: 8)
    }

    func setEnableButton() {
        isUserInteractionEnabled = true
    }

    func setDisableButton() {
        isUserInteractionEnabled = false
    }
}
