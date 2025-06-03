//
//  SubjectViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation
import UIKit

final class SubjectViewController: BaseUIViewController {

    // MARK: - UI Components
    private let subjectView = SubjectView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        setupTextFieldObserver()
        updateNextButtonState()
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(subjectView)
    }

    override func setLayout() {
        subjectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func addTarget() {
        subjectView.nextButton.addTarget(self, action: #selector(didTappedNextButton), for: .touchUpInside)
    }

    private func setupTextFieldObserver() {
        subjectView.subjectTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc
    private func textFieldDidChange() {
        updateNextButtonState()
    }

    private func updateNextButtonState() {
        let isFilled = !(subjectView.subjectTextField.text ?? "").isEmpty
        subjectView.nextButton.isEnabled = isFilled
    }

    // MARK: - Action Method
    @objc
    func didTappedNextButton() {
        guard let subject = subjectView.subjectTextField.text else { return }
        PoolCreateDataStore.shared.poolSubject = subject

        let createPoolVC = CreatPoolViewController()
        self.navigationController?.pushViewController(createPoolVC, animated: true)
    }
}
