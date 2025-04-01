//
//  CreatPoolViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation

final class CreatPoolViewController: BaseUIViewController {

    // MARK: - Properties

    var time: Float = 0.0
    var timer: Timer?

    // MARK: - UI Components
    private let creatPoolView = CreatPoolView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        creatPoolView.startAnimation()
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(creatPoolView)
    }

    override func setLayout() {
        creatPoolView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Action Method

    override func addTarget() {
        creatPoolView.nextButton.addTarget(self, action: #selector(didTappedNextButton), for: .touchUpInside)

    }

    @objc
    func didTappedNextButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

