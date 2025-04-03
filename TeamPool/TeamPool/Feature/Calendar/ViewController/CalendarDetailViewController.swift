//
//  CalendarDetailViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import Foundation
import UIKit

final class HalfModalViewController: UIViewController {

    private let date: Date

    init(date: Date) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(dateLabel)

        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().inset(30)
        }

        setDateLabel(for: date)
    }

    private func setDateLabel(for date: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "d"
        let day = formatter.string(from: date)

        formatter.dateFormat = "EEEE"
        let weekday = formatter.string(from: date)

        let attributed = NSMutableAttributedString()
        attributed.append(NSAttributedString(
            string: day + " ",
            attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .bold)]
        ))
        attributed.append(NSAttributedString(
            string: weekday,
            attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor: UIColor.darkGray]
        ))

        dateLabel.attributedText = attributed
    }
}
