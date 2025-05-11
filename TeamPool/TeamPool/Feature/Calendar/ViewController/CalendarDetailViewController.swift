import UIKit

final class CalendarDetailViewController: UIViewController {

    // MARK: - Properties
    private let date: Date
    private let calendarDetailView = CalendarDetailView()

    // MARK: - Initializer
    init(date: Date) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(calendarDetailView)

        calendarDetailView.snp.makeConstraints { $0.edges.equalToSuperview() }

        // ✅ 핵심: 이벤트 데이터 전달
        loadEvents(for: date)
    }

    // MARK: - Data Binding
    private func loadEvents(for date: Date) {
        let allEvents = CalendarModel.dummyData()
        let filteredEvents = allEvents.filter {
            guard let range = Calendar.current.dateInterval(of: .day, for: date) else { return false }
            return $0.startDate <= range.end && $0.endDate >= range.start
        }

        calendarDetailView.update(date: date, events: filteredEvents)
    }
}

