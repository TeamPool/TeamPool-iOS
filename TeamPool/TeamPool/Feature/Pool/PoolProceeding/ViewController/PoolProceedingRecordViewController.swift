//
//  PoolProceedingRecordViewController.swift
//  TeamPool
//
//  Created by 성현주 on 6/3/25.
//
import Foundation
import UIKit

final class PoolProceedingRecordViewController: BaseUIViewController {

    // MARK: - UI & Manager

    private let recordView = PoolProceedingRecordView()
    private let sttManager = SpeechRecognizerManager()
    private var recordModel = STTRecordModel()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // STT 실시간 텍스트 반영
        sttManager.onResult = { [weak self] transcript in
            self?.recordModel.transcript = transcript
            self?.recordView.statusLabel.text = transcript
        }

        // 권한 요청
        sttManager.requestAuthorization { granted in
            if !granted {
                self.showAlert(message: "음성 인식 권한이 필요합니다.")
            }
        }

        // 버튼 이벤트 연결
        recordView.recordButton.addTarget(self, action: #selector(didTapRecord), for: .touchUpInside)
        recordView.endButton.addTarget(self, action: #selector(didTapEnd), for: .touchUpInside)
    }

    // MARK: - UI 구성

    override func setUI() {
        view.addSubview(recordView)
    }

    override func setLayout() {
        recordView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - Action

    @objc private func didTapRecord() {
        recordView.recordButton.isHidden = true
        recordView.endButton.isHidden = false
        recordView.statusLabel.text = "듣는 중..."

        do {
            try sttManager.startRecording()
        } catch {
            showAlert(message: "음성 인식을 시작할 수 없습니다.")
        }
    }

    @objc private func didTapEnd() {
        sttManager.stopRecording()

        let alert = UIAlertController(title: "제목", message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "제목을 입력해주세요" }

        let confirm = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self else { return }

            let title = alert.textFields?.first?.text ?? "(제목 없음)"
            let content = self.recordView.statusLabel.text ?? "(내용 없음)"

            // GPT 요약 API 호출
            SummaryService().summarizeWithChatGPT(transcript: content) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let summary):
                        print("📝 [회의 저장 완료]")
                        print("제목: \(title)")
                        print("원문: \(content)")
                        print("요약: \(summary)")

                        self.navigationController?.popViewController(animated: true)

                    case .failure(let error):
                        self.showAlert(message: "요약 실패: \(error.localizedDescription)")
                    }
                }
            }
        }

        alert.addAction(confirm)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))

        present(alert, animated: true) {
            alert.textFields?.first?.becomeFirstResponder()
        }
    }



    // MARK: - Alert Helper

    private func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
    }
}
