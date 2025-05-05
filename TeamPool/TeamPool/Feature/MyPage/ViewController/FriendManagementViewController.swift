import UIKit

final class FriendManagementViewController: BaseUIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    private var friends: [MyPageModel] = [] // 전체 친구 목록
    private var filteredFriends: [MyPageModel] = [] // 필터링된 친구 목록
    private var sectionedFriends: [String: [MyPageModel]] = [:]
    private var sectionTitles: [String] = []
    
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
        createSections(from: filteredFriends)
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
        createSections(from: filteredFriends)
        friendManagementView.tableView.reloadData() // 테이블 뷰 새로 고침
    }
    private func getInitialConsonant(of name: String) -> String {
        guard let first = name.first else { return "#" }
        let scalar = first.unicodeScalars.first!.value
        
        let consonants = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        
        if scalar >= 0xAC00 && scalar <= 0xD7A3 {
            let index = (scalar - 0xAC00) / 28 / 21
            return consonants[Int(index)]
        } else {
            return "#"
        }
    }
    private func createSections(from friends: [MyPageModel]) {
        var sections: [String: [MyPageModel]] = [:]
        
        for friend in friends {
            let key = getInitialConsonant(of: friend.name)
            if sections[key] == nil {
                sections[key] = []
            }
            sections[key]?.append(friend)
        }
        
        sectionedFriends = sections
        sectionTitles = sections.keys.sorted()
    }
}

//MARK: - 테이블 뷰 수정

extension FriendManagementViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitles[section]
        return sectionedFriends[key]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = sectionTitles[indexPath.section]
        if let friend = sectionedFriends[key]?[indexPath.row] {
            print("\(friend.name) 선택됨")
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendManagementCell.identifier, for: indexPath) as? FriendManagementCell else {
            return UITableViewCell()
        }
        
        let key = sectionTitles[indexPath.section]
        if let friend = sectionedFriends[key]?[indexPath.row] {
            cell.configure(with: friend)
            cell.deleteButton.accessibilityIdentifier = "\(indexPath.section)-\(indexPath.row)"
            cell.deleteButton.addTarget(self, action: #selector(deleteFriend(_:)), for: .touchUpInside)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    @objc private func deleteFriend(_ sender: UIButton) {
        guard let id = sender.accessibilityIdentifier else { return }
        let components = id.split(separator: "-")

        guard components.count == 2,
              let section = Int(components[0]),
              let row = Int(components[1]),
              section >= 0, section < sectionTitles.count else {
            return
        }

        let key = sectionTitles[section]
        guard let friendsInSection = sectionedFriends[key],
              row >= 0, row < friendsInSection.count else {
            return
        }

        let friend = friendsInSection[row]

        let alert = UIAlertController(
            title: "\"\(friend.name)\"님을 친구 목록에서 삭제하시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: "취소", style: .default)

        let deleteAction = UIAlertAction(title: "삭제", style: .default) { _ in
            // 1. 원본 friends 배열에서 삭제
            self.friends.removeAll { $0.studentNumber == friend.studentNumber }

            // 2. 필터링 및 섹션 다시 구성
            self.filterFriends()
        }

        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}
    
//MARK: - 테이블 뷰 수정

