import UIKit

final class PoolProceedingCell: UITableViewCell {

    static let identifier = "PoolProceedingCell"

    private let dotView = UIView()
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        dotView.backgroundColor = .lightGray
        dotView.layer.cornerRadius = 4

        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .gray

        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .black

        contentView.addSubview(dotView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
    }

    private func setLayout() {
        dotView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(8)
        }

        dateLabel.snp.makeConstraints {
            $0.left.equalTo(dotView.snp.right).offset(8)
            $0.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.left.equalTo(dateLabel.snp.right).offset(8)
            $0.centerY.equalToSuperview()
            $0.right.lessThanOrEqualToSuperview().inset(16)
        }
    }

    func configure(with model: PoolProceedingModel) {
        dateLabel.text = model.shortDateString
        titleLabel.text = model.title
    }
}

