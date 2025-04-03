//
//  MyPageView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit

import SnapKit

class MyPageView: BaseUIView {

    // MARK: - UI Components
    
    var accountButtonAction: (() -> Void)?
    var friendButtonAction: (() -> Void)?
    var scheduleButtonAction: (() -> Void)?
    var userButtonAction: (() -> Void)?
    
    lazy var circleView: BaseUIView = {
        let circle = BaseUIView()
        circle.layer.cornerRadius = 25
        circle.backgroundColor = .clear
        let profile = UIImageView()
        profile.image = ImageLiterals.mypageProfile
        circle.addSubviews(profile)
        profile.snp.makeConstraints { make in
                make.edges.equalToSuperview()  // circleView 전체에 맞춤
        }
        return circle
    }()
    
    var tableView = UITableView()
    
    
        
    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Method
    
    override func setUI() {
        self.addSubview(circleView)
        self.addSubview(tableView)
        
    }
    
    override func setLayout() {
        circleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(25)
            $0.width.height.equalTo(50)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(circleView.snp.bottom).offset(30)  // circleView 아래로 30 간격
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

