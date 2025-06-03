
import UIKit

final class PoolCalendarAddViewController: BaseUIViewController {

    private let addView = PoolCalendarAddView()
    private let timePicker = UIDatePicker()
    private let datePicker = UIDatePicker()

    var poolId: Int

    init(poolId: Int) {
        self.poolId = poolId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        guard let title = addView.titleTextField.text,
              let place = addView.placeTextField.text,
              !title.isEmpty, !place.isEmpty else {
            showAlert(title: "입력 오류", message: "제목과 장소를 입력해주세요.")
            return
        }

        let startDateTime = combineDateAndTime(date: datePicker.date, time: timePicker.date)
        let endDateTime = Calendar.current.date(byAdding: .minute, value: 60, to: startDateTime) ?? startDateTime

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let startString = formatter.string(from: startDateTime)
        let endString = formatter.string(from: endDateTime)

        let dto = ScheduleCreateRequestDTO(
            poolId: poolId,
            title: title,
            startDatetime: startString,
            endDatetime: endString,
            place: place
        )

        AddPoolScheduleService().addPoolSchedule(request: dto) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .success:
                    self.showAlert(title: "완료", message: "일정이 추가되었습니다.") {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .requestErr(let msg):
                    self.showAlert(title: "추가 실패", message: msg)
                case .networkFail:
                    self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")
                default:
                    self.showAlert(title: "오류", message: "일정을 추가할 수 없습니다.")
                }
            }
        }
    }

    private func combineDateAndTime(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)

        var combined = DateComponents()
        combined.year = dateComponents.year
        combined.month = dateComponents.month
        combined.day = dateComponents.day
        combined.hour = timeComponents.hour
        combined.minute = timeComponents.minute
        combined.second = timeComponents.second

        return calendar.date(from: combined) ?? date
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }

}

