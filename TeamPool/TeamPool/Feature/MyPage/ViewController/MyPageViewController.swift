//
//  MyPageViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation
import UIKit

final class MyPageViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let myPageView = MyPageView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        myPageView.tableView.delegate = self
        myPageView.tableView.dataSource = self
        fetchMyInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchMyInfo()
    }


    // MARK: - Custom Method

    override func setUI() {
        myPageView.backgroundColor = .white
        view.addSubview(myPageView)
    }

    override func setLayout() {
        myPageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func fetchMyInfo() {
        MyPageService().getNickname { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.myPageView.nameLabel.text = model.myName
                    self?.myPageView.studentNumberLabel.text = model.myStudentNumber

                case .requestErr(let msg):
                    print("❌ 닉네임 요청 오류: \(msg)")

                case .networkFail:
                    print("❌ 닉네임 네트워크 오류 발생")

                default:
                    print("❌ 닉네임 알 수 없는 오류")
                }
            }
        }
    }


}


//MARK: - 테이블 뷰 수정
extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4  // <- Cell을 보여줄 갯수
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // 클릭 시 이동할 화면 설정
        var viewController: UIViewController

        switch indexPath.row {
        case 0:
            viewController = AccountManagementViewController()
            self.navigationItem.backButtonTitle = "계정 관리"
        case 1:
            viewController = ScheduleManagementViewController()
            self.navigationItem.backButtonTitle = "시간표 관리"
        case 2:
            viewController = FriendManagementViewController()
            self.navigationItem.backButtonTitle = "친구 관리"
        case 3:
            viewController = UserAgreementViewController()
            self.navigationItem.backButtonTitle = "이용 약관"
        default:
            return
        }

        // 화면 이동
        navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
            }
        cell.backgroundColor = UIColor(hex: 0xEFF5FF)
        let icon: UIImage?
        switch indexPath.row {
        case 0:
            icon = ImageLiterals.settingProfile
        case 1:
            icon = ImageLiterals.settingCalendar
        case 2:
            icon = ImageLiterals.settingFriend
        case 3:
            icon = ImageLiterals.settingAgreement
        default:
            icon = ImageLiterals.settingFriend
        }
        
        let title = ["계정 관리", "시간표 관리", "친구 관리", "이용 약관"]
        cell.configure(icon: icon, title: title[indexPath.row])
        return cell
    }
}
