import UIKit

final class PoolProceedingViewController: BaseUIViewController {

    private let proceedingView = PoolProceedingView()
    private var meetings: [PoolProceedingModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        meetings = PoolProceedingModel.dummyData()
        proceedingView.tableView.delegate = self
        proceedingView.tableView.dataSource = self
    }

    override func setUI() {
        view.addSubview(proceedingView)
    }

    override func setLayout() {
        proceedingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PoolProceedingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PoolProceedingCell.identifier, for: indexPath) as? PoolProceedingCell else {
            return UITableViewCell()
        }
        cell.configure(with: meetings[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = PoolProceedingDetailViewController(meeting: meetings[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

