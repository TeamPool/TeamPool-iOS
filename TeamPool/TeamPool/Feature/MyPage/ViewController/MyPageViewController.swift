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
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4  // <- Cell을 보여줄 갯수
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()    // <- 보여줄 Cell
    }
}



