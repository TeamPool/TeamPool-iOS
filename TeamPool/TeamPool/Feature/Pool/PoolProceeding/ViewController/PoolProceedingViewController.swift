//
//  PoolProceedingViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit

final class PoolProceedingViewController: BaseUIViewController {

    private let proceedingView = PoolProceedingView()
    private let poolId: Int
    private var meetings: [PoolProceedingModel] = []


    init(poolId: Int) {
            self.poolId = poolId
            super.init(nibName: nil, bundle: nil)
        }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        meetings = PoolProceedingModel.dummyData()
        proceedingView.tableView.delegate = self
        proceedingView.tableView.dataSource = self
        proceedingView.addbutton.addTarget(self, action: #selector(didTapAddMeetingButton), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPoolNotes()
    }

    override func setUI() {
        view.addSubview(proceedingView)
    }

    override func setLayout() {
        proceedingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func didTapAddMeetingButton() {
        let addVC = PoolProceedingRecordViewController(poolId: poolId) 
        navigationController?.pushViewController(addVC, animated: true)
    }

    private func fetchPoolNotes() {
        PoolService().fetchPoolNotes(poolId: poolId) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let dtos):
                self.meetings = dtos.map { PoolProceedingModel(from: $0) }
                self.proceedingView.setEmptyState(self.meetings.isEmpty) 
                self.proceedingView.tableView.reloadData()

            case .requestErr(let msg):
                self.showAlert(title: "회의 목록 조회 실패", message: msg)

            case .networkFail:
                self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")

            default:
                self.showAlert(title: "오류", message: "회의 목록을 가져올 수 없습니다.")
            }
        }
    }

    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
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

