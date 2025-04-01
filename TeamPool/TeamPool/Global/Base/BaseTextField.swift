//
//  BaseTextField.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit

final class BaseTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        let placeholderText = "이곳에 입력하세요"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray, // 원하는 색상
            .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 18)! // 원하는 폰트
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)

        self.backgroundColor = .white
        self.setRoundBorder()
        self.autocapitalizationType = .none
        self.clearButtonMode = .always
    }
}

extension UITextField {

    /// 글자 시작위치 변경
    func addLeftPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    /// border 설정
    func setRoundBorder() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 2
    }

    /// 좌측 이미지 추가
    func addLeftImage(image: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: image.size.height))
        leftImageView.image = image

        // 패딩 값 추가
        let padding: CGFloat = 16.0
        let paddingLeftView = UIView(frame: CGRect(x: 0, y: 0, width: leftImageView.frame.width + padding + 8.0 , height: 20 ))
        leftImageView.frame.origin = CGPoint(x: padding, y: 0)
        leftImageView.contentMode = .scaleAspectFit

        paddingLeftView.addSubview(leftImageView)
        self.leftView = paddingLeftView
        self.leftViewMode = .always

    }

    /// 좌측 글자 추가
    func addLeftLabel(text: String) {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 20)
        label.sizeToFit()

        let padding: CGFloat = 16.0

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: label.frame.width + padding + 8.0, height: self.frame.height))
        label.frame.origin = CGPoint(x: padding, y: (self.frame.height - label.frame.height) / 2)

        leftView.addSubview(label)
        self.leftView = leftView
        self.leftViewMode = .always
    }
}
