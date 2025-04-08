//
//  CalendarView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit
import FSCalendar
import SnapKit

final class CalendarView: BaseUIView, FSCalendarDataSource, FSCalendarDelegateAppearance {

    // MARK: - UI Components

    private let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scope = .month
        calendar.layer.cornerRadius = 0
        calendar.clipsToBounds = true
        calendar.appearance.borderRadius = 0
        calendar.appearance.eventDefaultColor = .clear
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.todayColor = .clear // 오늘 표시 제거
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.borderSelectionColor = .clear
        calendar.appearance.weekdayTextColor = .darkGray
        return calendar
    }()

    private let eventDates: [Date] = [
        Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
        Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
        Calendar.current.date(byAdding: .day, value: 5, to: Date())!
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setCalendar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setCalendar() {
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(BlockCalendarCell.self, forCellReuseIdentifier: "BlockCalendarCell")
    }

    override func setUI() {
        self.addSubview(calendar)
        self.backgroundColor = .white
    }

    override func setLayout() {
        calendar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
    }

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "BlockCalendarCell", for: date, at: position) as! BlockCalendarCell
        let eventCount = eventDates.filter { Calendar.current.isDate($0, inSameDayAs: date) }.count
        cell.configure(eventCount: eventCount)
        return cell
    }

}

final class BlockCalendarCell: FSCalendarCell {

    private var eventDots: [UIView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        setupDots()
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.layer.borderWidth = 0.5
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDots() {
        for _ in 0..<3 { // 최대 3개의 점
            let dot = UIView()
            dot.backgroundColor = .systemBlue
            dot.layer.cornerRadius = 3
            dot.isHidden = true
            contentView.addSubview(dot)
            eventDots.append(dot)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let totalWidth = CGFloat(eventDots.count * 6 + (eventDots.count - 1) * 4)
        var startX = (bounds.width - totalWidth) / 2
        let yPosition = bounds.height - 10

        for dot in eventDots {
            dot.frame = CGRect(x: startX, y: yPosition, width: 6, height: 6)
            startX += 10
        }
    }

    func configure(eventCount: Int) {
        for (index, dot) in eventDots.enumerated() {
            dot.isHidden = index >= eventCount
        }
    }
}
// MARK: - FSCalendarDelegate
extension CalendarView: FSCalendarDelegate {

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presentHalfModal(for: date)
    }

    private func presentHalfModal(for date: Date) {
        let vc = HalfModalViewController(date: date)
        if let topVC = UIApplication.shared.keyWindow?.rootViewController {
            vc.modalPresentationStyle = .pageSheet
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }
            topVC.present(vc, animated: true)
        }
    }
}
