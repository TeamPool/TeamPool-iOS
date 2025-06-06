//
//  PoolTimeTableView.swift
//  TeamPool
//
//  Created by 성현주 on 5/7/25.
//

import Foundation
import UIKit
import SnapKit
import Univ_TimeTable

class PoolTimeTableView: BaseUIView {

    // MARK: - UI Components

    lazy var timeTable: UnivTimeTable = {
        let table = UnivTimeTable()
        table.elliotBackgroundColor = .white
        table.borderWidth = 1
        table.borderColor = .systemGray5
        table.textEdgeInsets = UIEdgeInsets(top: 2, left: 3, bottom: 2, right: 10)
        table.courseItemMaxNameLength = 18
        table.courseItemTextSize = 12.5
        table.courseTextAlignment = .left
        table.borderCornerRadius = 24
        table.roomNameFontSize = 8
        table.courseItemHeight = 70.0
        table.symbolFontSize = 12
        table.symbolTimeFontSize = 12
        table.symbolFontColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        table.symbolTimeFontColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        return table
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        timeTable.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Method

    override func setUI() {
        self.addSubview(timeTable)
    }

    override func setLayout() {
        timeTable.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(40)
            make.bottom.equalToSuperview()
        }

    }
}
