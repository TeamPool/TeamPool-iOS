import UIKit

final class FindPeopleViewController: BaseUIViewController {

    // MARK: - Data
    private var friends: [FindPeopleModel] = []
    private var filteredFriends: [FindPeopleModel] = []
    private var sectionedFriends: [String: [FindPeopleModel]] = [:]
    private var sectionTitles: [String] = []
    private var selectedFriends: Set<String> = []

    // MARK: - UI Components
    private let findPeopleView = FindPeopleView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadDummyData()
        setSearchTargets()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func setUI() {
        view.addSubview(findPeopleView)
    }

    override func setLayout() {
        findPeopleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Setup
    private func setupTableView() {
        findPeopleView.tableView.delegate = self
        findPeopleView.tableView.dataSource = self
        findPeopleView.tableView.register(FindPeopleCell.self, forCellReuseIdentifier: FindPeopleCell.identifier)
        findPeopleView.searchBar.delegate = self
    }

    private func setSearchTargets() {
        findPeopleView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        findPeopleView.nextButton.addTarget(self, action: #selector(didTappedNextButton), for: .touchUpInside)
    }

    // MARK: - Load & Filter
    private func loadDummyData() {
        friends = FindPeopleModel.dummyData()
        filteredFriends = friends
        createSections(from: filteredFriends)
        findPeopleView.tableView.reloadData()
    }

    private func filterFriends() {
        guard let searchText = findPeopleView.searchBar.text else { return }

        filteredFriends = searchText.isEmpty
            ? friends
            : friends.filter {
                $0.name.contains(searchText) || $0.studentNumber.contains(searchText)
            }

        createSections(from: filteredFriends)
        findPeopleView.tableView.reloadData()
    }

    private func createSections(from friends: [FindPeopleModel]) {
        var sections: [String: [FindPeopleModel]] = [:]
        for friend in friends {
            let key = getInitialConsonant(of: friend.name)
            sections[key, default: []].append(friend)
        }
        sectionedFriends = sections
        sectionTitles = sections.keys.sorted()
    }

    private func getInitialConsonant(of name: String) -> String {
        guard let first = name.first else { return "#" }
        let scalar = first.unicodeScalars.first!.value
        let consonants = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        return (scalar >= 0xAC00 && scalar <= 0xD7A3) ? consonants[Int((scalar - 0xAC00) / 28 / 21)] : "#"
    }

    // MARK: - Actions
    @objc private func searchButtonTapped() {
        print("🔍 검색 버튼 눌림")
        filterFriends()
    }

    @objc private func didTappedNextButton() {
        let selectedList = friends.filter { selectedFriends.contains($0.studentNumber) }
        print("✅ 선택된 친구 목록:", selectedList.map { $0.name })
        let deadlineVC = DeadlineViewController()
        self.navigationController?.pushViewController(deadlineVC, animated: true)
    }
}

// MARK: - TableView
extension FindPeopleViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionTitles[section]
        return sectionedFriends[key]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FindPeopleCell.identifier, for: indexPath) as? FindPeopleCell else {
            return UITableViewCell()
        }

        let key = sectionTitles[indexPath.section]
        if let friend = sectionedFriends[key]?[indexPath.row] {
            let isSelected = selectedFriends.contains(friend.studentNumber)
            cell.configure(with: friend, isSelected: isSelected)
            cell.checkBoxButton.tag = indexPath.section * 1000 + indexPath.row
            cell.checkBoxButton.addTarget(self, action: #selector(toggleSelection(_:)), for: .touchUpInside)
        }

        return cell
    }

    @objc private func toggleSelection(_ sender: UIButton) {
        let section = sender.tag / 1000
        let row = sender.tag % 1000
        let key = sectionTitles[section]

        guard let friend = sectionedFriends[key]?[row] else { return }

        if selectedFriends.contains(friend.studentNumber) {
            selectedFriends.remove(friend.studentNumber)
        } else {
            selectedFriends.insert(friend.studentNumber)
        }

        findPeopleView.tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .none)
    }
}

// MARK: - SearchBar 실시간 검색
extension FindPeopleViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFriends()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // 키보드 내리기
        filterFriends()
    }
}

