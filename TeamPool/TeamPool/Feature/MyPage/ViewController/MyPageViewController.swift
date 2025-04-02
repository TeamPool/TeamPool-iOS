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
        navigationItem.title = "MyPage"
        
        myPageView.accountButtonAction = { [weak self] in
            self?.showAccountManagementViewController()
        }
        
        myPageView.friendButtonAction = { [weak self] in
            self?.showFrinedManagementViewController()
        }
        
        myPageView.scheduleButtonAction = { [weak self] in
            self?.showScheduleManagementViewController()
        }
        
        myPageView.userButtonAction = { [weak self] in
            self?.showUserAgreementViewController()
        }
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
    @objc func showAccountManagementViewController() {
        let accountManegement = AccountManagementViewController()
        navigationController?.pushViewController(accountManegement, animated: true)
        }
    @objc func showFrinedManagementViewController() {
        let friendManagement = FriendManagementViewController()
        navigationController?.pushViewController(friendManagement, animated: true)
        }
    
    @objc func showScheduleManagementViewController() {
        let scheduleManagement = ScheduleManagementViewController()
        navigationController?.pushViewController(scheduleManagement, animated: true)
        }
    
    @objc func showUserAgreementViewController() {
        let userAgreement = UserAgreementViewController()
        navigationController?.pushViewController(userAgreement, animated: true)
        }

}

//MARK: - 곧 없어질 예정
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}




