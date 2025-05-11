import UIKit

final class CalendarDetailView: BaseUIView {

    // MARK: - UI Components

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    private let scrollView = UIScrollView()

    private let contentStackView: UIStackView = {
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
        addSubview(dateLabel)
        addSubview(scrollView)
        scrollView.addSubview(contentStackView)
    }

    override func setLayout() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.width.equalToSuperview().inset(20)
        }
    }

    func update(date: Date, events: [CalendarModel]) {
        // 날짜 라벨 갱신
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "d EEEE"
        dateLabel.text = formatter.string(from: date)

        // 기존 카드 제거
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        // 카드 추가
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
        titleLabel.text = "회의"
        titleLabel.font = .boldSystemFont(ofSize: 17)

        let subjectLabel = UILabel()
        subjectLabel.text = event.subjectName
        subjectLabel.font = .systemFont(ofSize: 15)

        let timeLabel = UILabel()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeLabel.text = "\(timeFormatter.string(from: event.startDate)) ~ \(timeFormatter.string(from: event.endDate))"
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
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            horizontalStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            horizontalStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16)
        ])

        return card
    }
}

