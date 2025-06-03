import UIKit

final class PoolProceedingDetailViewController: BaseUIViewController {

    private let meeting: PoolProceedingModel
    private let detailView = PoolProceedingDetailView()

    // MARK: - Initializer

    init(meeting: PoolProceedingModel) {
        self.meeting = meeting
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "회의 상세"
        detailView.configure(with: meeting)
    }

    override func setUI() {
        view.addSubview(detailView)
    }

    override func setLayout() {
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview() // ✅ 전체 화면 덮도록 설정
        }
    }
}

