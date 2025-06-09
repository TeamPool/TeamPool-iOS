//
//  HomeViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation
import UIKit

final class HomeViewController: BaseUIViewController {

    // MARK: - Properties

    private var poolList: [HomeModel] = []
    private var hasFetchedLecture = false

    // MARK: - UI Components

    private let homeView = HomeView()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isHidden = false
        fetchMyPools()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)

        fetchMyPools()
        checkLectureSaved()
    }

    // MARK: - Custom Method

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "Pool"
    }

    override func setUI() {
        view.addSubview(homeView)
    }

    override func setLayout() {
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func checkLectureSaved() {
        TimeTableService().getMyTimeTables { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let timetableList):
                    if timetableList.isEmpty {
                        self.showLectureImportAlert()
                    } else {
                        print("✅ 시간표 저장되어 있음. 알림 안띄움.")
                    }

                case .requestErr(let msg):
                    print("❌ 시간표 요청 오류: \(msg)")

                case .networkFail:
                    self.showAlert(title: "네트워크 오류", message: "시간표 확인에 실패했습니다.")

                default:
                    print("❌ 기타 오류 발생")
                }
            }
        }
    }

    private func showLectureImportAlert() {
        BaseAlertViewController.showAlert(
            on: self,
            title: "시간표 불러오기",
            message: "원활한 TeamPool 사용을 위해 \n 개인 시간표를 불러옵니다",
            confirmTitle: "계속",
            cancelTitle: "취소",
            confirmHandler: { [weak self] in
                guard let self = self else { return }
                let loginVC = UsaintLogInViewController()
                self.navigationController?.pushViewController(loginVC, animated: true)
            },
            cancelHandler: {
                print("⛔️ 시간표 불러오기 취소됨")
            }
        )
    }

    private func fetchMyPools() {
        PoolService().fetchMyPools { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .success(let dtoList):
                    self.poolList = dtoList.map { HomeModel.from(dto: $0) }
                    self.homeView.tableView.reloadData()

                case .requestErr(let msg):
                    self.showAlert(title: "불러오기 실패", message: msg)

                case .networkFail:
                    self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")

                default:
                    self.showAlert(title: "오류", message: "스터디 목록 불러오기에 실패했어요.")
                }
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    // MARK: - Action Method

    override func addTarget() {
        homeView.floatingButton.addTarget(self, action: #selector(didTappedFloatingButton), for: .touchUpInside)
    }

    @objc
    func didTappedFloatingButton() {
        let addPoolVC = AddPoolNameViewController()
        self.navigationController?.pushViewController(addPoolVC, animated: true)
    }
}


// MARK: - TableViewDatasource & Delegate

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poolList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        let pool = poolList[indexPath.row]
        cell.configure(with: pool)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}

extension HomeViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedPool = poolList[indexPath.row]
        let poolVC = PoolViewController(poolID: selectedPool.poolId)
        navigationController?.pushViewController(poolVC, animated: true)
    }

}
