import UIKit

final class FriendManagementViewController: BaseUIViewController {

    // MARK: - 데이터 구조
    private enum FriendRow {
        case sectionHeader(String)
        case person(FindPeopleModel)
    }

    private var friends: [FindPeopleModel] = []
    private var filteredFriends: [FindPeopleModel] = []
    private var tableRows: [FriendRow] = []

    // MARK: - UI
    private let friendManagementView = FriendManagementView()

    // MARK: - 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureCustomBackButton()
        fetchFriendsFromAPI()
        friendManagementView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }

    override func setUI() {
        view.addSubview(friendManagementView)
        view.backgroundColor = .white
    }

    override func setLayout() {
        friendManagementView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - 설정
    private func fetchFriendsFromAPI() {
        FriendsService().fetchFriends { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    self?.friends = models
                    self?.filteredFriends = models
                    self?.buildTableRows(from: models)
                    self?.friendManagementView.tableView.reloadData()
                case .requestErr(let msg):
                    print("❌ 요청 오류: \(msg)")
                case .networkFail:
                    print("❌ 네트워크 실패")
                default:
                    print("❌ 알 수 없는 오류")
                }
            }
        }
    }

    private func setupTableView() {
        let tableView = friendManagementView.tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(FriendManagementCell.self, forCellReuseIdentifier: FriendManagementCell.identifier)
        tableView.register(SectionHeaderCell.self, forCellReuseIdentifier: SectionHeaderCell.identifier)
        friendManagementView.searchBar.delegate = self
    }

    private func loadDummyData() {
        filteredFriends = friends
        buildTableRows(from: filteredFriends)
        friendManagementView.tableView.reloadData()
    }

    private func filterFriends() {
        let searchText = friendManagementView.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        filteredFriends = searchText.isEmpty
            ? friends
            : friends.filter { $0.studentNumber.contains(searchText) }

        buildTableRows(from: filteredFriends)
        friendManagementView.tableView.reloadData()
    }

    private func buildTableRows(from models: [FindPeopleModel]) {
        let grouped = Dictionary(grouping: models) { getInitialConsonant(of: $0.name) }
        let sortedKeys = grouped.keys.sorted()

        var rows: [FriendRow] = []
        for key in sortedKeys {
            rows.append(.sectionHeader(key))
            for person in grouped[key] ?? [] {
                rows.append(.person(person))
            }
        }
        tableRows = rows
    }

    private func getInitialConsonant(of name: String) -> String {
        guard let first = name.first else { return "#" }
        let scalar = first.unicodeScalars.first!.value
        let consonants = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        return (scalar >= 0xAC00 && scalar <= 0xD7A3) ? consonants[Int((scalar - 0xAC00) / 28 / 21)] : "#"
    }

    // MARK: - 액션
    @objc private func searchButtonTapped() {
        filterFriends()
    }
}
// MARK: - UITableView
extension FriendManagementViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableRows[indexPath.row] {
        case .sectionHeader:
            return 28
        case .person:
            return 50
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableRows[indexPath.row] {
        case .sectionHeader(let title):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionHeaderCell.identifier, for: indexPath) as? SectionHeaderCell else {
                return UITableViewCell()
            }
            cell.configure(with: title)
            return cell

        case .person(let friend):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendManagementCell.identifier, for: indexPath) as? FriendManagementCell else {
                return UITableViewCell()
            }
            cell.configure(with: friend)
            cell.deleteButton.accessibilityIdentifier = "\(indexPath.row)"
            cell.deleteButton.addTarget(self, action: #selector(deleteFriend(_:)), for: .touchUpInside)
            return cell
        }
    }

    @objc private func deleteFriend(_ sender: UIButton) {
        guard let id = sender.accessibilityIdentifier, let row = Int(id) else { return }
        guard case .person(let friend) = tableRows[row] else { return }

        let alert = UIAlertController(
            title: "\"\(friend.name)\"님을 친구 목록에서 삭제하시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: "취소", style: .default)
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            self.friends.removeAll { $0.studentNumber == friend.studentNumber }
            self.filterFriends()
        }

        alert.addAction(deleteAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
    // MARK: - 커스텀 백버튼

    private func configureCustomBackButton() {
        let backButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        backButton.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        backButton.setTitle(" 친구 관리", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        let backItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backItem
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension FriendManagementViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFriends()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filterFriends()
    }
}

