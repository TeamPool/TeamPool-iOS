//
//  MyPageViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation
import UIKit

final class FriendManagementViewController: BaseUIViewController {
    
    // MARK: - Properties
    private var friends: [MyPageModel] = []
    // MARK: - UI Components
    
    private let friendManagementView = FriendManagementView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "친구 관리"
        setupTableView()
        loadDummyData()
    }
    
    // MARK: - Custom Method
    
    override func setUI() {
        view.addSubview(friendManagementView)
    }
    
    override func setLayout() {
        friendManagementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        friendManagementView.tableView.delegate = self
        friendManagementView.tableView.dataSource = self
    }
    
    private func loadDummyData() {
        friends = MyPageModel.dummyData()
        friendManagementView.tableView.reloadData()
    }

}
    
//MARK: - 테이블 뷰 수정

extension FriendManagementViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let friend = friends[indexPath.row]
        print("\(friend.name) 선택됨")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendManagementCell.identifier, for: indexPath) as? FriendManagementCell else {
            return UITableViewCell()
        }
        
        let friend = friends[indexPath.row]
        cell.configure(with: friend)
        
        return cell
    }
    
    @objc private func deleteFriend(_ sender: UIButton) {
        let row = sender.tag
        friends.remove(at: row)
        friendManagementView.tableView.reloadData()
    }
}


