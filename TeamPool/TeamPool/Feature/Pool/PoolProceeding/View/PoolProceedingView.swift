import UIKit
import SnapKit

final class PoolProceedingView: BaseUIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PoolProceedingCell.self, forCellReuseIdentifier: PoolProceedingCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    override func setUI() {
        self.addSubview(tableView)
    }

    override func setLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

