import Foundation
import UIKit

final class PoolProceedingRecordViewController: BaseUIViewController {

    private let recordView = PoolProceedingRecordView()

    override func viewDidLoad() {
        super.viewDidLoad()
        recordView.recordButton.addTarget(self, action: #selector(didTapRecord), for: .touchUpInside)
        recordView.endButton.addTarget(self, action: #selector(didTapEnd), for: .touchUpInside)
    }

    override func setUI() {
        view.addSubview(recordView)
    }

    override func setLayout() {
        recordView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc private func didTapRecord() {
        recordView.recordButton.isHidden = true
        recordView.endButton.isHidden = false
        recordView.statusLabel.text = "녹음 종료"
    }

    @objc private func didTapEnd() {

        // ✅ UIAlertController로 bottom sheet 형식 제목 입력창 띄우기!!
        let alert = UIAlertController(title: "제목", message: nil, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "제목"
        }

        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let title = alert.textFields?.first?.text {
                print("입력된 제목: \(title)")
                // 저장 또는 처리 로직 여기에!
                self.navigationController?.popViewController(animated: true)
            }
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        // iPad 대응용 (iOS14+는 없어도 되지만 안전하게)
        if let popover = alert.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX,
                                        y: self.view.bounds.midY,
                                        width: 0, height: 0)
            popover.permittedArrowDirections = []
        }

        self.present(alert, animated: true) {
            alert.textFields?.first?.becomeFirstResponder()
        }
    }

}

