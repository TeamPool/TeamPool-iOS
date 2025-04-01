//
//  AddPoolViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import Foundation

final class AddPoolNameViewController: BaseUIViewController {

    // MARK: - Data

    // MARK: - UI Components
    private let addPoolNameView = AddPoolNameView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        updateSubjectList()
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(addPoolNameView)
    }

    override func setLayout() {
        addPoolNameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func updateSubjectList() {
        let lectureNames = LectureModel.shared.getLectureNames()
        addPoolNameView.configureSubjectList(lectureNames)
    }
}
