//
//  HomeViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation

final class HomeViewController: BaseUIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private let homeView = HomeView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // 알람 테스트 => 지울 예정
        UserDefaultHandler.lecturesSaved = false
        print(UserDefaultHandler.lecturesSaved)


        checkLectureSaved()
    }

    // MARK: - Custom Method

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationItem.title = "Pool"
    }

    override func setUI() {
        view.addSubview(homeView)
    }

    override func setLayout() {
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func checkLectureSaved() {
        if !UserDefaultHandler.lecturesSaved {
            showLectureImportAlert()
        }else{
            print("저장되어있")
        }


    }

    private func showLectureImportAlert() {
        BaseAlertViewController.showAlert(
                on: self,
                title: "시간표 불러오기",
                message: "원활한 TeamPool 사용을 위해 \n 개인 시간표를 불러옵니다",
                confirmTitle: "계속",
                cancelTitle: "취소",
                confirmHandler: { [weak self] in
                    let loginVC = UsaintLogInViewController()
                    loginVC.modalPresentationStyle = .pageSheet
                    if let sheet = loginVC.sheetPresentationController {
                        sheet.detents = [.medium(), .large()] // 하프, 풀 두단계
                        sheet.prefersGrabberVisible = true    // 위에 그립바 표시 여부
                        sheet.preferredCornerRadius = 20
                    }
                    self?.present(loginVC, animated: true)
                },
                cancelHandler: {
                    print("취소됨")
                }
            )
    }


    // MARK: - Action Method

    override func addTarget() {
        homeView.exampleButton.addTarget(self, action: #selector(didTappedExampleButton), for: .touchUpInside)

    }

    @objc
    func didTappedExampleButton() {
        print("홈버튼 클릭")
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}


