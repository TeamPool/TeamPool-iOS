//
//  FriendManagementViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//
import UIKit

final class FriendManagementViewController: BaseUIViewController {

    private enum FriendRow {
        case sectionHeader(String)
        case person(FindPeopleModel)
    }

    private var friends: [FindPeopleModel] = []
    private var filteredFriends: [FindPeopleModel] = []
    private var tableRows: [FriendRow] = []
    private var isSearchResultMode: Bool = false // 검색 결과 모드 여부

    private let friendManagementView = FriendManagementView()

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

    private func fetchFriendsFromAPI() {
        isSearchResultMode = false
        FriendsService().fetchFriends { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    self?.friends = models
                    self?.filteredFriends = models
                    self?.buildTableRows(from: models)
                    self?.friendManagementView.tableView.reloadData()
                case .requestErr(let msg):
                    self?.showAlert(title: "요청 오류", message: msg)
                case .networkFail:
                    self?.showAlert(title: "네트워크 오류", message: "네트워크 연결을 확인해주세요.")
                default:
                    self?.showAlert(title: "오류", message: "알 수 없는 오류가 발생했습니다.")
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

    private func filterFriends() {
        let searchText = friendManagementView.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        filteredFriends = searchText.isEmpty ? friends : friends.filter { $0.studentNumber.contains(searchText) }
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

    @objc private func searchButtonTapped() {
        let query = friendManagementView.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !query.isEmpty else {
            fetchFriendsFromAPI()
            return
        }

        FriendsService().searchFriend(by: query) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .success(let friend):
                    self.isSearchResultMode = true
                    self.filteredFriends = [friend]
                    self.buildTableRows(from: [friend])
                    self.friendManagementView.tableView.reloadData()

                case .requestErr(let msg):
                    self.showAlert(title: "검색 실패", message: msg)
                case .networkFail:
                    self.showAlert(title: "검색 실패", message: "네트워크 오류가 발생했습니다.")
                default:
                    self.showAlert(title: "검색 실패", message: "해당 학번의 친구를 찾을 수 없습니다.")
                }
            }
        }
    }

    @objc private func deleteFriend(_ sender: UIButton) {
        guard let id = sender.accessibilityIdentifier,
              let row = Int(id),
              case .person(let friend) = tableRows[row] else { return }

        let alert = UIAlertController(
            title: "\"\(friend.name)\"님을 친구 목록에서 삭제하시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "취소", style: .default))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            guard let self = self else { return }

            FriendsService().deleteFriend(friendUserId: friend.friendId ?? -1) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.friends.removeAll { $0.studentNumber == friend.studentNumber }
                        self.filterFriends()
                    case .requestErr(let msg):
                        self.showAlert(title: "삭제 실패", message: msg)
                    case .networkFail:
                        self.showAlert(title: "삭제 실패", message: "네트워크 오류가 발생했습니다.")
                    default:
                        self.showAlert(title: "삭제 실패", message: "알 수 없는 오류가 발생했습니다.")
                    }
                }
            }
        })

        present(alert, animated: true)
    }

    @objc private func acceptFriend(_ sender: UIButton) {
        guard let id = sender.accessibilityIdentifier,
              let row = Int(id),
              case .person(let friend) = tableRows[row] else { return }

        FriendsService().addFriends(by: friend.studentNumber) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .success:
                    self.showAlert(title: "친구 추가 성공", message: "\"\(friend.name)\"님이 친구로 추가되었습니다.")
                    self.fetchFriendsFromAPI()
                case .requestErr(let msg):
                    self.showAlert(title: "친구 추가 실패", message: msg)
                case .networkFail:
                    self.showAlert(title: "친구 추가 실패", message: "네트워크 오류가 발생했습니다.")
                default:
                    self.showAlert(title: "친구 추가 실패", message: "알 수 없는 오류가 발생했습니다.")
                }
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }

    private func configureCustomBackButton() {
        let backButton = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        backButton.setImage(UIImage(systemName: "chevron.left", withConfiguration: config), for: .normal)
        backButton.setTitle(" 친구 관리", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
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

            cell.configure(with: friend, isSearchResult: isSearchResultMode)
            cell.deleteButton.accessibilityIdentifier = "\(indexPath.row)"
            cell.deleteButton.removeTarget(nil, action: nil, for: .allEvents)

            if isSearchResultMode {
                cell.deleteButton.addTarget(self, action: #selector(acceptFriend(_:)), for: .touchUpInside)
            } else {
                cell.deleteButton.addTarget(self, action: #selector(deleteFriend(_:)), for: .touchUpInside)
            }

            return cell
        }
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
