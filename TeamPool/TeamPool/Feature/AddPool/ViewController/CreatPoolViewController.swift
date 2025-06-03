//
//  CreatPoolViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit

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
        print("📝 Pool 생성 데이터 확인")
        print("팀 이름: \(PoolCreateDataStore.shared.name ?? "nil")")
        print("팀 설명: \(PoolCreateDataStore.shared.subject ?? "nil")")
        print("과목: \(PoolCreateDataStore.shared.poolSubject ?? "nil")")
        print("마감일: \(PoolCreateDataStore.shared.deadline ?? "nil")")
        print("참여 학번 목록: \(PoolCreateDataStore.shared.memberStudentNumbers)")

        // DTO 생성
        guard let dto = PoolCreateDataStore.shared.generateDTO() else {
               showAlert(title: "데이터 오류", message: "모든 항목을 올바르게 입력했는지 확인해주세요.")
               return
           }

        // API 호출
        PoolService().createPool(with: dto) { [weak self] result in
               DispatchQueue.main.async {
                   guard let self = self else { return }

                   switch result {
                   case .success(let poolId):
                       print("✅ Pool 생성 성공 - poolId: \(poolId)")
                       self.showAlert(title: "성공", message: "Pool이 성공적으로 생성되었습니다.") {
                           self.navigationController?.popToRootViewController(animated: true)
                           PoolCreateDataStore.shared.reset()
                       }

                   case .requestErr(let msg):
                       self.showAlert(title: "생성 실패", message: msg)

                   case .networkFail:
                       self.showAlert(title: "네트워크 오류", message: "인터넷 연결을 확인해주세요.")

                   default:
                       self.showAlert(title: "오류", message: "알 수 없는 오류가 발생했습니다.")
                   }
               }
           }
    }

    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }

}

