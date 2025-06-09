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
        button.isHidden = true // 초기엔 숨김
        return button
    }()

    // 상태 텍스트
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "녹음 시작"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    override func setUI() {
        addSubview(recordButton)
        addSubview(endButton)
        addSubview(statusLabel)
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

        statusLabel.snp.makeConstraints {
            $0.top.equalTo(recordButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}

