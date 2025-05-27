//
//  CalendarView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit
import FSCalendar
import SnapKit

final class PoolCalendarView: BaseUIView, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    // MARK: - UI Components

    private let calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.locale = Locale(identifier: "en_US")
        calendar.scope = .month
        calendar.layer.cornerRadius = 0
        calendar.clipsToBounds = true

        calendar.appearance.borderRadius = 0
        calendar.appearance.eventDefaultColor = .clear
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.todayColor = .clear
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.borderSelectionColor = .clear
        calendar.appearance.selectionColor = .clear
        calendar.appearance.weekdayTextColor = UIColor(hex: 0x969696)
        calendar.appearance.titlePlaceholderColor = .lightGray
        calendar.appearance.headerTitleColor = .black

        calendar.placeholderType = .fillHeadTail
        calendar.adjustsBoundingRectWhenChangingMonths = true

        return calendar
    }()

    private let events: [PoolCalendarModel] = PoolCalendarModel.dummyData()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setCalendar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setCalendar() {
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(PoolCalendarCell.self, forCellReuseIdentifier: "PoolCalendarCell") // ✅ 변경된 셀 이름
    }

    override func setUI() {
        self.addSubview(calendar)
        self.backgroundColor = .white
    }

    override func setLayout() {
        calendar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
    }

    // MARK: - FSCalendar DataSource

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "PoolCalendarCell", for: date, at: position) as! PoolCalendarCell

        let matchingEvents = events.filter {
            guard let range = Calendar.current.dateInterval(of: .day, for: date) else { return false }
            return $0.startDate <= range.end && $0.endDate >= range.start
        }
        let colors = matchingEvents.map { $0.color }
        let isOutsideMonth = (position == .previous || position == .next)

        cell.configure(colors: colors, isOutsideMonth: isOutsideMonth)
        return cell
    }

    // MARK: - FSCalendar Delegate

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presentHalfModal(for: date)
    }

    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        self.layoutIfNeeded()
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .black // 선택해도 텍스트 색 고정
    }

    private func presentHalfModal(for date: Date) {
        let vc = PoolCalendarDetailViewController(date: date)
        vc.modalPresentationStyle = .pageSheet
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }

        if let topVC = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first(where: { $0.isKeyWindow })?.rootViewController {
            topVC.present(vc, animated: true)
        }
    }
}

