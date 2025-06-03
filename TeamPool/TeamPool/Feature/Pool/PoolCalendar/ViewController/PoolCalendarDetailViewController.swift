import UIKit

final class PoolCalendarDetailViewController: BaseUIViewController {

    // MARK: - Properties

    private let date: Date

    // MARK: - UI Components

    private let poolCalendarDetailView = PoolCalendarDetailView()

    // MARK: - Initializer

    init(date: Date) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents(for: date)
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(poolCalendarDetailView)
        view.backgroundColor = .white
    }

    override func setLayout() {
        poolCalendarDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func loadEvents(for date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)

        AddPoolScheduleService().fetchSchedulesByDay(date: dateString) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let dtos):
                    let events = dtos.map { PoolCalendarModel(from: $0) }
                    self.poolCalendarDetailView.update(date: date, events: events)

                case .requestErr(let msg):
                    self.showAlert(title: "불러오기 실패", message: msg)

                case .networkFail:
                    self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")

                default:
                    self.showAlert(title: "오류", message: "일정을 불러올 수 없습니다.")
                }
            }
        }
    }

    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}
