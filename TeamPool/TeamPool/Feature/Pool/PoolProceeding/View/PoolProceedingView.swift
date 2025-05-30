import UIKit
import SnapKit

final class PoolProceedingView: BaseUIView {

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

    override func setUI() {
        self.addSubviews(tableView,
                         addbutton)
    }

    override func setLayout() {
        addbutton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(32)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

