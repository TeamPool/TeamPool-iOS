//
//  SettingTableViewCell.swift
//  TeamPool
//
//  Created by Mac on 4/5/25.
//

import Foundation
import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"  // <- TableViewCell에 고유 id 지정
    
    let iconImageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let arrowImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = ImageLiterals.settingArrow
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
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
    }
    
    private func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(54)
            $0.centerY.equalToSuperview()
        }
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(16)
            $0.width.equalTo(8)
        }
    }
    
    func configure(icon: UIImage?, title : String) {
        iconImageView.image = icon
        titleLabel.text = title
    }
}
