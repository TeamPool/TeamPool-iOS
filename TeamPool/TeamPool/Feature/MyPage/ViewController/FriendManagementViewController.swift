import UIKit

final class FriendManagementViewController: BaseUIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    private var friends: [MyPageModel] = [] // 전체 친구 목록
    private var filteredFriends: [MyPageModel] = [] // 필터링된 친구 목록
    
    // MARK: - UI Components
    private let friendManagementView = FriendManagementView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadDummyData()
        filteredFriends = friends // 초기에는 모든 데이터를 보여줌
        friendManagementView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(friendManagementView)
        view.backgroundColor = UIColor(hex : 0xEFF5FF)
    }
    
    override func setLayout() {
        friendManagementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        friendManagementView.tableView.delegate = self
        friendManagementView.tableView.dataSource = self
        friendManagementView.searchBar.delegate = self // UISearchBar delegate 설정
    }
    
    private func loadDummyData() {
        friends = MyPageModel.dummyData()
        filteredFriends = friends // 초기에는 모든 데이터를 보여줌
        friendManagementView.tableView.reloadData()
    }
    
    // MARK: - Action
    @objc private func searchButtonTapped() {
        // 검색 버튼을 눌렀을 때, 학번으로 필터링
        filterFriends()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 텍스트가 변경될 때마다 호출됨
        filterFriends()
    }
    
    private func filterFriends() {
        guard let searchText = friendManagementView.searchBar.text else { return }
        
        // 검색 텍스트가 비어 있으면 전체 목록을 표시
        if searchText.isEmpty {
            filteredFriends = friends
        } else {
            // 학번으로 필터링
            filteredFriends = friends.filter { $0.studentNumber.contains(searchText) }
        }
        friendManagementView.tableView.reloadData() // 테이블 뷰 새로 고침
    }
    
}

//MARK: - 테이블 뷰 수정

extension FriendManagementViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count // 필터링된 친구 목록을 사용
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let friend = filteredFriends[indexPath.row] // 필터링된 친구 목록 사용
        print("\(friend.name) 선택됨")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendManagementCell.identifier, for: indexPath) as? FriendManagementCell else {
            return UITableViewCell()
        }
        
        let friend = filteredFriends[indexPath.row] // 필터링된 친구 목록 사용
        cell.configure(with: friend)
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteFriend(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc private func deleteFriend(_ sender: UIButton) {
        let row = sender.tag
        let friend = filteredFriends[row] // 필터링된 친구 목록 사용
        let alert = UIAlertController(
            title: "\"\(friend.name)\"님을 친구 목록에서 삭제하시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        
        let deleteAction = UIAlertAction(title: "삭제", style: .default) { _ in
            // 삭제 작업
            self.friends.removeAll { $0.studentNumber == friend.studentNumber } // 원본 friends 배열에서 삭제
            self.filteredFriends = self.friends // 필터링된 배열도 갱신
            self.friendManagementView.tableView.reloadData() // 테이블 뷰 새로 고침
        }
        
        // 알림에 버튼 추가
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        // 알림 표시
        present(alert, animated: true, completion: nil)
    }
}
    
//MARK: - 테이블 뷰 수정

