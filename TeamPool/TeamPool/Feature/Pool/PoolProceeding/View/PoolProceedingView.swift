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
            $0.bottom.equalToSuperview().inset(100)
            $0.width.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

