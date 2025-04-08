//
//  Withdrawal.swift
//  TeamPool
//
//  Created by Mac on 4/8/25.
//

import Foundation
import UIKit
class WithdrawalCell: UITableViewCell {
    
    static let identifier = "WithdrawalCell"
    
    let WithdrawalLabel: UILabel = {
        let label = UILabel()
        label.text = "계정 탈퇴"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
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
        contentView.addSubview(WithdrawalLabel)
    }
    
    private func setLayout() {
        WithdrawalLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
        }
    }
}
