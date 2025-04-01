//
//  AddPoolViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import Foundation

final class AddPoolViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let addPoolView = AddPoolView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "AddPool"
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(addPoolView)
    }

    override func setLayout() {
        addPoolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


