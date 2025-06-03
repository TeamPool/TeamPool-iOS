
import UIKit

final class PoolCalendarAddViewController: BaseUIViewController {

    private let addView = PoolCalendarAddView()
    private let timePicker = UIDatePicker()
    private let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTimePicker()
        configureDatePicker()
        setupActions()
        addView.submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
    }

    override func setUI() {
        view.addSubview(addView)
    }

    override func setLayout() {
        addView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureTimePicker() {
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "en_US")
        addView.timeTextField.inputView = timePicker
        addView.timeTextField.inputAccessoryView = makeToolbar(selector: .time)
    }

    private func configureDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        addView.dateTextField.inputView = datePicker
        addView.dateTextField.inputAccessoryView = makeToolbar(selector: .date)
    }

    private func makeToolbar(selector: SelectorType) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(didTapCancel))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "확인", style: .done, target: self, action: selector == .time ? #selector(didSelectTime) : #selector(didSelectDate))
        toolbar.setItems([cancel, flexible, done], animated: false)
        return toolbar
    }

    private enum SelectorType {
        case date
        case time
    }

    private func setupActions() {
        addView.titleTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        addView.placeTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }

    @objc private func didTapCancel() {
        view.endEditing(true)
    }

    @objc private func didSelectTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        addView.timeTextField.text = formatter.string(from: timePicker.date)
        view.endEditing(true)
        validateForm()
    }

    @objc private func didSelectDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        addView.dateTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
        validateForm()
    }

    @objc private func textChanged() {
        validateForm()
    }

    private func validateForm() {
        let isValid = !(addView.titleTextField.text?.isEmpty ?? true) &&
                      !(addView.timeTextField.text?.isEmpty ?? true) &&
                      !(addView.dateTextField.text?.isEmpty ?? true) &&
                      !(addView.placeTextField.text?.isEmpty ?? true)

        addView.submitButton.isEnabled = isValid
        addView.submitButton.backgroundColor = isValid ? UIColor(hex: 0x4E709D) : UIColor(hex: 0xCACACA)
    }
    
    @objc private func didTapSubmit() {
        self.navigationController?.popViewController(animated: true)
    }
}

