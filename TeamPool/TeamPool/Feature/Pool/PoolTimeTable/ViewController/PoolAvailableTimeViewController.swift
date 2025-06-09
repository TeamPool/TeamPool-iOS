//
//  PoolAvailableTimeViewController.swift
//  TeamPool
//
//  Created by 성현주 on 5/7/25.
//

import UIKit

final class PoolAvailableTimeViewController: BaseUIViewController {

    // MARK: - Data

    var poolId: Int

    private let weekDayMapping: [String: String] = [
        "MONDAY": "월요일",
        "TUESDAY": "화요일",
        "WEDNESDAY": "수요일",
        "THURSDAY": "목요일",
        "FRIDAY": "금요일",
        "SATURDAY": "토요일",
        "SUNDAY": "일요일"
    ]

    // MARK: - UI Components
    private let poolAvailableTimeView = PoolAvailableTimeView()

    // MARK: - Init

    init(poolId: Int) {
        self.poolId = poolId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAvailableTimes()
    }

    // MARK: - Custom Method

    override func setUI() {
        view.addSubview(poolAvailableTimeView)
    }

    override func setLayout() {
        poolAvailableTimeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func fetchAvailableTimes() {
        PoolService().fetchAvailableTimes(poolId: poolId) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let responseDTO):
                let models: [AvailableTimeModel] = self.weekDayMapping.map { (eng, kor) in
                    let times = responseDTO.availableTimes[eng] ?? []
                    return AvailableTimeModel(day: kor, times: times)
                }
                self.poolAvailableTimeView.configure(with: models)

            case .requestErr(let message):
                self.showAlert(message: message)
            case .pathErr, .serverErr, .networkFail:
                self.showAlert(message: "가능한 시간을 불러오지 못했습니다.")
            }
        }
    }

    // MARK: - Action Method

    @objc
    func didTappedNextButton() {
        let findPeopleVC = FindPeopleViewController()
        self.navigationController?.pushViewController(findPeopleVC, animated: true)
    }

    private func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
    }
}
