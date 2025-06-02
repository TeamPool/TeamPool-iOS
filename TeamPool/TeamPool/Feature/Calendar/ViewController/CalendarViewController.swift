//
//  CalendarViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation
import UIKit

final class CalendarViewController: BaseUIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let calendarView = CalendarView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar"
        calendarView.addbutton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    // MARK: - Custom Method
    
    override func setUI() {
        view.addSubview(calendarView)
    }
    
    override func setLayout() {
        calendarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func didTapAddButton() {
        let addVC = CalendarAddViewController()
        addVC.modalPresentationStyle = .pageSheet
        if let sheet = addVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()] // 하프 모달
            sheet.prefersGrabberVisible = true     // 윗부분 바도 보여주기
            sheet.preferredCornerRadius = 20
        }
        present(addVC, animated: true)
        
    }
}
