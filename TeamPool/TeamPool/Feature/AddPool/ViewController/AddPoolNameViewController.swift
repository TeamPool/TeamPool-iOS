//
//  AddPoolViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import Foundation
import UIKit

final class AddPoolNameViewController: BaseUIViewController {

    // MARK: - UI Components
    private let addPoolNameView = AddPoolNameView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        updateSubjectList()
        addTextFieldObservers()
    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(addPoolNameView)
        addPoolNameView.nextButton.isEnabled = false
        addPoolNameView.nextButton.alpha = 0.5
    }

    override func setLayout() {
        addPoolNameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func updateSubjectList() {
        TimeTableService().getMyTimeTables { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let dtos):
                    let lectures = dtos.map { $0.toLecture() }
                    LectureModel.shared.lectures = lectures
                    let lectureNames = LectureModel.shared.getLectureNames()
                    self.addPoolNameView.configureSubjectList(lectureNames)

                case .requestErr(let msg):
                    self.showAlert(title: "시간표 불러오기 실패", message: msg)

                case .networkFail:
                    self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")

                default:
                    self.showAlert(title: "오류", message: "과목 목록을 불러올 수 없습니다.")
                }
            }
        }
    }


    private func addTextFieldObservers() {
        addPoolNameView.teamNameTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        addPoolNameView.subjectSelectTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }

    @objc private func textFieldsDidChange() {
        let name = addPoolNameView.teamNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let subject = addPoolNameView.subjectSelectTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        let isFilled = !name.isEmpty && !subject.isEmpty
        addPoolNameView.nextButton.isEnabled = isFilled
        addPoolNameView.nextButton.alpha = isFilled ? 1.0 : 0.5
    }

    // MARK: - Action Method
    override func addTarget() {
        addPoolNameView.nextButton.addTarget(self, action: #selector(didTappedNextButton), for: .touchUpInside)
    }

    @objc
    func didTappedNextButton() {
        guard let name = addPoolNameView.teamNameTextField.text,
              !name.isEmpty,
              let subject = addPoolNameView.subjectSelectTextField.text else {
            showAlert(title: "입력 오류", message: "스터디 이름과 과목을 모두 입력해주세요.")
            return
        }

        PoolCreateDataStore.shared.name = name
        PoolCreateDataStore.shared.subject = subject

        let findPeopleVC = FindPeopleViewController()
        self.navigationController?.pushViewController(findPeopleVC, animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
