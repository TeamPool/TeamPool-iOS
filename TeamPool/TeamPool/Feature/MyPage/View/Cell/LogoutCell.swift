//
//  LogoutCell.swift
//  TeamPool
//
//  Created by Mac on 4/7/25.
//

import Foundation
import UIKit
class LogoutCell: UITableViewCell {
    
    static let identifier = "LogoutCell"

    let LogoutLabel: UILabel = {
        let label = UILabel()
        label.text = "로그아웃"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let LogoutImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = ImageLiterals.LogoutIcon
            imageView.tintColor = .gray
            return imageView
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI() {
        contentView.addSubview(LogoutLabel)
        contentView.addSubview(LogoutImageView)
    }
    
    private func setLayout() {
        LogoutLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }
        LogoutImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24)
        }
    }
}
