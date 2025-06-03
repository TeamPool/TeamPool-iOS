//
//  CalendarViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import UIKit

final class PoolCalendarViewController: BaseUIViewController {

    // MARK: - Properties
    var poolId: Int

    // MARK: - UI Components

    private let poolCalendarView = PoolCalendarView()

    // MARK: - Life Cycle
    init(poolId: Int) {
        self.poolId = poolId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar"
        poolCalendarView.addbutton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        fetchSchedules()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchSchedules()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(poolCalendarView)
    }

    override func setLayout() {
        poolCalendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func didTapAddButton() {
        let addVC = PoolCalendarAddViewController(poolId: poolId)
        navigationController?.pushViewController(addVC, animated: true)
    }

    private func fetchSchedules() {
        AddPoolScheduleService().fetchSchedules(poolId: poolId) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let dtos):
                    let models = dtos.map { PoolCalendarModel(from: $0) }
                    self.poolCalendarView.updateEvents(models)
                case .requestErr(let msg):
                    self.showAlert(title: "일정 불러오기 실패", message: msg)
                case .networkFail:
                    self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")
                default:
                    self.showAlert(title: "오류", message: "일정을 가져올 수 없습니다.")
                }
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
