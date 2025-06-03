//
//  CalendarViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation

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

}
