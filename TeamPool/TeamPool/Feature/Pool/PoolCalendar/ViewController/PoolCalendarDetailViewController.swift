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
        let allEvents = PoolCalendarModel.dummyData()
        let filteredEvents = allEvents.filter {
            guard let range = Calendar.current.dateInterval(of: .day, for: date) else { return false }
            return $0.startDate <= range.end && $0.endDate >= range.start
        }

        poolCalendarDetailView.update(date: date, events: filteredEvents)
    }
}

