//
//  CalendarCell.swift
//  TeamPool
//

import FSCalendar
import UIKit

final class CalendarCell: FSCalendarCell {

    private var eventBars: [UIView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.layer.borderWidth = 0.5

        // 최대 3개의 바를 미리 생성해서 추가
        for _ in 0..<3 {
            let bar = UIView()
            bar.backgroundColor = UIColor.CalendarColar1
            bar.layer.cornerRadius = 2
            bar.isHidden = true
            contentView.insertSubview(bar, at: 0)
            eventBars.insert(bar, at: 0)
        }
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // 날짜 텍스트 위치 설정
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.frame = CGRect(
            x: 4,
            y: 4,
            width: bounds.width - 8,
            height: 20
        )

        // 이벤트 바 위치 설정 (아래쪽 정렬)
        let barHeight: CGFloat = 5
        let spacing: CGFloat = 3
        let visibleBars = eventBars.filter { !$0.isHidden }
        let totalHeight = CGFloat(visibleBars.count) * barHeight + CGFloat(visibleBars.count - 1) * spacing
        let barWidth = bounds.width * 0.8
        let x = (bounds.width - barWidth) / 2
        var y = bounds.height - totalHeight - 6
        for bar in visibleBars.reversed() {
            bar.frame = CGRect(x: x, y: y, width: barWidth, height: barHeight)
            y += barHeight + spacing
        }

    }

    /// 이벤트 개수 기반으로 바 표시
    func configure(colors: [UIColor], isOutsideMonth: Bool) {
        for (index, bar) in eventBars.enumerated() {
            if index < colors.count {
                bar.isHidden = false
                bar.backgroundColor = colors[index]
            } else {
                bar.isHidden = true
            }
        }

        contentView.backgroundColor = isOutsideMonth ? UIColor(hex: 0xF8F8F8) : .white
    }
}

