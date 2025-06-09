import UIKit
import SnapKit

final class PoolProceedingView: BaseUIView {

    // MARK: - UI Components

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PoolProceedingCell.self, forCellReuseIdentifier: PoolProceedingCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    lazy var addbutton: UIButton = {
        let button = UIButton()
        button.setTitle("회의 추가", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(hex: 0x5A75A6)
        button.layer.cornerRadius = 6
        return button
    }()

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 회의가 없습니다.\n회의를 만들어보세요!"
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()

    // MARK: - UI Setup

    override func setUI() {
        self.addSubviews(tableView, addbutton, emptyLabel)
    }

    override func setLayout() {
        addbutton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(100)
            $0.width.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    // MARK: - Empty State Control

    func setEmptyState(_ isEmpty: Bool) {
        emptyLabel.isHidden = !isEmpty
        tableView.isHidden = isEmpty
    }
}
