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

    private var poolList: [PoolModel] = []

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
        poolList = PoolModel.dummyData()

        // 알람 테스트 => 지울 예정
        UserDefaultHandler.lecturesSaved = false
        print(UserDefaultHandler.lecturesSaved)

        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.register(PoolCell.self, forCellReuseIdentifier: PoolCell.identifier)

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
                    let loginVC = UsaintLogInViewController()
                    loginVC.modalPresentationStyle = .pageSheet
                    if let sheet = loginVC.sheetPresentationController {
                        sheet.detents = [.medium(), .large()] // 하프, 풀 두단계
                        sheet.prefersGrabberVisible = true    // 위에 그립바 표시 여부
                        sheet.preferredCornerRadius = 20
                    }
                    self?.present(loginVC, animated: true)
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poolList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PoolCell.identifier, for: indexPath) as? PoolCell else {
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
