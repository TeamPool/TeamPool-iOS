import UIKit
import SnapKit

final class PoolProceedingRecordView: BaseUIView {

    // 녹음 시작 버튼
    lazy var recordButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.poolRecord_start, for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    // 녹음 종료 버튼
    lazy var endButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.poolRecord_end, for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.isHidden = true
        return button
    }()

    // 상태 출력용 스크롤 뷰 + 라벨
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "녹음 시작"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0 // ✅ 줄바꿈 허용
        label.textColor = .black
        return label
    }()

    // MARK: - UI Setup

    override func setUI() {
        addSubview(recordButton)
        addSubview(endButton)
        addSubview(scrollView)
        scrollView.addSubview(statusLabel)
    }

    override func setLayout() {
        recordButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(120)
        }

        endButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(120)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(recordButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).inset(20)
            $0.height.greaterThanOrEqualTo(120)
        }

        statusLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview() // 중요: 이걸 해줘야 contentSize 자동 계산
            $0.width.equalTo(scrollView.snp.width)
        }
    }
}
