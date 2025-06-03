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

    // MARK: - UI Components

    private let homeView = HomeView()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //더미 데이터
        poolList = HomeModel.dummyData()

        // 알람 테스트 => 지울 예정
        UserDefaultHandler.lecturesSaved = false
        print(UserDefaultHandler.lecturesSaved)

        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)

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
        if !UserDefaultHandler.lecturesSaved {
            showLectureImportAlert()
        }else{
            print("저장되어있")
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
                print("취소됨")
            }
        )
    }


    // MARK: - Action Method

    override func addTarget() {
        homeView.floatingButton.addTarget(self, action: #selector(didTappedFloatingButton), for: .touchUpInside)

    }

    @objc
    func didTappedFloatingButton() {
        print("플로팅 버튼 클릭")
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
