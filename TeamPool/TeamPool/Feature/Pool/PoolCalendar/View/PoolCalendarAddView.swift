
import UIKit
import SnapKit

final class PoolCalendarAddView: BaseUIView {

    let titleLabel = PoolCalendarAddView.makeLabel("제목")
    let dateLabel = PoolCalendarAddView.makeLabel("날짜")
    let timeLabel = PoolCalendarAddView.makeLabel("시간")
    let placeLabel = PoolCalendarAddView.makeLabel("장소")

    let titleTextField = PoolCalendarAddView.makeTextField(placeholder: "제목")
    let dateTextField = PoolCalendarAddView.makeSelectorField(placeholder: "선택")
    let timeTextField = PoolCalendarAddView.makeSelectorField(placeholder: "선택")
    let placeTextField = PoolCalendarAddView.makeTextField(placeholder: "장소")

    let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("일정 추가하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(hex: 0xCACACA)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.08
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 6
        return button
    }()

    override func setUI() {
        self.backgroundColor = UIColor(hex: 0xF7F9FC)
        [titleLabel, titleTextField,
         dateLabel, dateTextField,
         timeLabel, timeTextField,
         placeLabel, placeTextField,
         submitButton].forEach { self.addSubview($0) }
    }

    override func setLayout() {
        let fields = [
            (titleLabel, titleTextField),
            (dateLabel, dateTextField),
            (timeLabel, timeTextField),
            (placeLabel, placeTextField)
        ]

        var lastBottom = self.safeAreaLayoutGuide.snp.top
        for (label, field) in fields {
            label.snp.makeConstraints {
                $0.top.equalTo(lastBottom).offset(24)
                $0.leading.equalToSuperview().offset(20)
            }
            field.snp.makeConstraints {
                $0.top.equalTo(label.snp.bottom).offset(6)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.height.equalTo(50)
            }
            lastBottom = field.snp.bottom
        }

        submitButton.snp.makeConstraints {
            $0.top.equalTo(lastBottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }

    static func makeLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }

    static func makeTextField(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.font = .boldSystemFont(ofSize: 18)
        tf.backgroundColor = UIColor(hex: 0xEFF5FF)
        tf.layer.cornerRadius = 8
        tf.layer.borderColor = UIColor(hex: 0xD9D9D9).cgColor
        tf.layer.borderWidth = 1
        tf.setLeftPadding(12)
        return tf
    }

    static func makeSelectorField(placeholder: String) -> UITextField {
        let tf = makeTextField(placeholder: placeholder)
        tf.rightView = UIImageView(image: UIImage(systemName: "chevron.down"))
        tf.rightViewMode = .always
        tf.tintColor = .clear
        return tf
    }
}

extension UITextField {
    func setLeftPadding(_ padding: CGFloat) {
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = spacer
        self.leftViewMode = .always
    }
}

