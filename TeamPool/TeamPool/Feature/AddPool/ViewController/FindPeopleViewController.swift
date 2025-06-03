import UIKit

final class FindPeopleViewController: BaseUIViewController {

    private enum FindPeopleRow {
        case sectionHeader(String)
        case person(FindPeopleModel)
    }

    // MARK: - Data
    private var friends: [FindPeopleModel] = []
    private var filteredFriends: [FindPeopleModel] = []
    private var tableRows: [FindPeopleRow] = []
    private var selectedFriends: Set<String> = []

    // MARK: - UI
    private let findPeopleView = FindPeopleView()

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
        findPeopleView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    private func setupTableView() {
        let tableView = findPeopleView.tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FindPeopleCell.self, forCellReuseIdentifier: FindPeopleCell.identifier)
        findPeopleView.tableView.separatorStyle = .none
        tableView.register(SectionHeaderCell.self, forCellReuseIdentifier: SectionHeaderCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        findPeopleView.searchBar.delegate = self
    }

    private func setSearchTargets() {
        findPeopleView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        findPeopleView.nextButton.addTarget(self, action: #selector(didTappedNextButton), for: .touchUpInside)
    }

    private func loadDummyData() {
        friends = FindPeopleModel.dummyData()
        filteredFriends = friends
        buildTableRows(from: filteredFriends)
        findPeopleView.tableView.reloadData()
    }

    private func filterFriends() {
        guard let searchText = findPeopleView.searchBar.text else { return }

        filteredFriends = searchText.isEmpty
            ? friends
            : friends.filter { $0.name.contains(searchText) || $0.studentNumber.contains(searchText) }

        buildTableRows(from: filteredFriends)
        findPeopleView.tableView.reloadData()
    }

    private func buildTableRows(from models: [FindPeopleModel]) {
        let grouped = Dictionary(grouping: models) { getInitialConsonant(of: $0.name) }
        let sortedKeys = grouped.keys.sorted()

        var rows: [FindPeopleRow] = []
        for key in sortedKeys {
            rows.append(.sectionHeader(key))
            for person in grouped[key]! {
                rows.append(.person(person))
            }
        }
        self.tableRows = rows
    }

    private func getInitialConsonant(of name: String) -> String {
        guard let first = name.first else { return "#" }
        let scalar = first.unicodeScalars.first!.value
        let consonants = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
        return (scalar >= 0xAC00 && scalar <= 0xD7A3) ? consonants[Int((scalar - 0xAC00) / 28 / 21)] : "#"
    }

    @objc private func searchButtonTapped() {
        filterFriends()
    }

    @objc private func didTappedNextButton() {
        let selected = friends.filter { selectedFriends.contains($0.studentNumber) }
        print("선택된 친구 목록: \(selected.map { $0.name })")
        let deadlineVC = DeadlineViewController()
        navigationController?.pushViewController(deadlineVC, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension FindPeopleViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableRows[indexPath.row] {
        case .sectionHeader: return 28
        case .person: return 50
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

        case .person(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FindPeopleCell.identifier, for: indexPath) as? FindPeopleCell else {
                return UITableViewCell()
            }
            let isSelected = selectedFriends.contains(model.studentNumber)
            cell.configure(with: model, isSelected: isSelected)
            cell.checkBoxButton.tag = indexPath.row
            cell.checkBoxButton.addTarget(self, action: #selector(toggleSelection(_:)), for: .touchUpInside)
            return cell
        }
    }

    @objc private func toggleSelection(_ sender: UIButton) {
        let rowIndex = sender.tag
        guard case .person(let model) = tableRows[rowIndex] else { return }

        if selectedFriends.contains(model.studentNumber) {
            selectedFriends.remove(model.studentNumber)
        } else {
            selectedFriends.insert(model.studentNumber)
        }

        findPeopleView.tableView.reloadRows(at: [IndexPath(row: rowIndex, section: 0)], with: .none)
    }
}

// MARK: - SearchBarDelegate
extension FindPeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFriends()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        filterFriends()
    }
}

