import UIKit
import SnapKit

class SectionHeaderCell: UITableViewCell {
    
    static let identifier = "SectionHeaderCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    private let topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xEFF5FF) // 아주 연한 파란색
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        contentView.backgroundColor = .white
        
        contentView.addSubview(topBorderView)
        contentView.addSubview(titleLabel)

        topBorderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(3) // ⬅️ 상단에만 아주 얇게 들어감
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(4)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}

