import UIKit
import SnapKit

final class CalendarDetailView: BaseUIView {

    // MARK: - UI Components

    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()

    lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        return stack
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Method

    override func setUI() {
        self.addSubview(dayLabel)
        self.addSubview(weekLabel)
        self.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
    }

    override func setLayout() {
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        weekLabel.snp.makeConstraints {
            $0.bottom.equalTo(dayLabel.snp.bottom).inset(3)
            $0.leading.equalTo(dayLabel.snp.trailing).offset(5)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }

    func update(date: Date, events: [CalendarModel]) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "d"
        dayLabel.text = formatter.string(from: date)
        formatter.dateFormat = "EEEE"
        weekLabel.text = formatter.string(from: date)

        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for event in events {
            let card = makeEventCard(for: event)
            contentStackView.addArrangedSubview(card)
        }
    }

    private func makeEventCard(for event: CalendarModel) -> UIView {
        let card = UIView()
        card.layer.cornerRadius = 12
        card.backgroundColor = UIColor(hex: 0xF2F8FC)

        let icon = UIImageView(image: UIImage(systemName: "person.2.fill"))
        icon.tintColor = event.color
        icon.setContentHuggingPriority(.required, for: .horizontal)

        let titleLabel = UILabel()
        titleLabel.text = event.title
        titleLabel.font = .boldSystemFont(ofSize: 17)

        let subjectLabel = UILabel()
        subjectLabel.text = event.subjectName
        subjectLabel.font = .systemFont(ofSize: 15)

        let timeLabel = UILabel()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeLabel.text = "\(formatter.string(from: event.startDate)) ~ \(formatter.string(from: event.endDate))"
        timeLabel.font = .systemFont(ofSize: 15)

        let placeLabel = UILabel()
        placeLabel.text = event.place
        placeLabel.font = .systemFont(ofSize: 15)

        let infoStack = UIStackView(arrangedSubviews: [titleLabel, subjectLabel, timeLabel, placeLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4

        let horizontalStack = UIStackView(arrangedSubviews: [icon, infoStack])
        horizontalStack.spacing = 16
        horizontalStack.alignment = .top

        card.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        card.addSubview(horizontalStack)
        
        horizontalStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }

        return card
    }
}

