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
    }
    

    // MARK: - Custom Method

    override func setUI() {
        myPageView.backgroundColor = UIColor(hex : 0xEFF5FF)
        view.addSubview(myPageView)
    }

    override func setLayout() {
        myPageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - 곧 없어질 예정

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
        case 1:
            viewController = ScheduleManagementViewController()
        case 2:
            viewController = FriendManagementViewController()
        case 3:
            viewController = UserAgreementViewController()
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



