//
//  BaseTableViewCell.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {}

    func setLayout() {}

}

