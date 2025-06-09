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
            guard let self = self else { return }

            // 빈 텍스트일 경우 무시하고 기존 transcript 유지
            if transcript.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return }

            self.recordModel.transcript = transcript
            self.recordView.statusLabel.text = transcript
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
            self.waitForTranscript(title: title)
        }

        alert.addAction(confirm)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))

        present(alert, animated: true) {
            alert.textFields?.first?.becomeFirstResponder()
        }
    }
    private func waitForTranscript(title: String) {
        let loading = UIAlertController(title: nil, message: "요약 중입니다...\n\n", preferredStyle: .alert)

        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loading.view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loading.view.centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: loading.view.bottomAnchor, constant: -20)
        ])
        activityIndicator.startAnimating()
        present(loading, animated: true)

        // 최대 3초까지 대기하면서 텍스트 길이 확인
        var checkCount = 0
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            checkCount += 1
            let transcript = self.recordModel.transcript.trimmingCharacters(in: .whitespacesAndNewlines)

            if !transcript.isEmpty && transcript.count > 10 {
                timer.invalidate()
                loading.dismiss(animated: true) {
                    self.requestSummary(title: title, content: transcript)
                }
            }

            if checkCount >= 6 { // 0.5초 * 6 = 3초
                timer.invalidate()
                loading.dismiss(animated: true) {
                    print("⚠️ STT 결과 부족으로 요약을 생략합니다.")
                    self.showAlert(message: "충분한 음성 인식 결과가 없어 요약을 생략합니다.")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    private func requestSummary(title: String, content: String) {
        print("📝 [회의 저장 완료]")
        print("제목: \(title)")
        print("원문: \(content)")

        SummaryService().summarizeWithChatGPT(transcript: content) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let summary):
                    print("요약: \(summary)")
                    self.navigationController?.popViewController(animated: true)

                case .failure(let error):
                    self.showAlert(message: "요약 실패: \(error.localizedDescription)")
                }
            }
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
