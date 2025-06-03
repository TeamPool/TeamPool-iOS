import UIKit
import SnapKit

final class PoolProceedingDetailView: BaseUIView {

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회의 제목"
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2025.05.29"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "회의에 대한 내용이 여기에 들어갑니다.\n긴 텍스트가 들어가도 줄바꿈이 됩니다."
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()

    // MARK: - Setup

    override func setUI() {
        self.addSubviews(titleLabel, dateLabel, descriptionLabel)
        self.backgroundColor = .white
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100) // 네비게이션 바 여유
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }

    // MARK: - Configure

    func configure(with meeting: PoolProceedingModel) {
        titleLabel.text = meeting.title
        dateLabel.text = meeting.dateString
        descriptionLabel.text = meeting.description
    }
}

