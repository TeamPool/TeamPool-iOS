//
//  BaseFillButton.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit

import SnapKit

class BaseFillButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            isEnabled ? setEnableButton() : setDisableButton()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFillButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupFillButton() {
        self.addTitleAttribute(title: "", titleColor: .white, fontName: UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!)
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 8
        self.isEnabled = false
    }

    func setEnableButton() {
        isUserInteractionEnabled = true
        backgroundColor = .systemBlue
    }

    func setDisableButton() {
        isUserInteractionEnabled = false
        backgroundColor = .systemBlue
    }
}


extension UIButton {

    /// Button 타이틀 속성 지정
    func addTitleAttribute(title: String, titleColor: UIColor, fontName: UIFont) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = fontName
    }

    /// Button border 속성 지정
    func setRoundBorder(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
    }
}
