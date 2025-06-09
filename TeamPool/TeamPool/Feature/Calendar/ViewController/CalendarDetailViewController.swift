import UIKit

final class CalendarDetailViewController: BaseUIViewController {

    // MARK: - Properties

    private let date: Date
    private let allEvents: [CalendarModel]

    // MARK: - UI Components

    private let calendarDetailView = CalendarDetailView()

    // MARK: - Initializer

    init(date: Date, events: [CalendarModel]) {
        self.date = date
        self.allEvents = events
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents(for: date)
        calendarDetailView.dontShowAgainSwitch.addTarget(self, action: #selector(didToggleDontShowAgain), for: .valueChanged)
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(calendarDetailView)
        view.backgroundColor = .white
    }

    override func setLayout() {
        calendarDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func loadEvents(for date: Date) {
        let filteredEvents = allEvents.filter {
            guard let range = Calendar.current.dateInterval(of: .day, for: date) else { return false }
            return $0.startDate <= range.end && $0.endDate >= range.start
        }

        calendarDetailView.update(date: date, events: filteredEvents)
    }

    @objc private func didToggleDontShowAgain(_ sender: UISwitch) {
//        if sender.isOn {
//            let todayKey = Self.makeTodayKey()
//            UserDefaults.standard.set(true, forKey: todayKey)
//        }
        if sender.isOn {
            self.dismiss(animated: true)
        }
    }

    private static func makeTodayKey() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return "dontShowCalendarPopup-\(formatter.string(from: Date()))"
    }
}
