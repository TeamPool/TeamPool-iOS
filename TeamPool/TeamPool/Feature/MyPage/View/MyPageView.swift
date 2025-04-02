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
    
    lazy var accountButton: UIButton = {
        let account = UIButton(type: .system)
        account.setTitle("계정 관리", for: .normal)
        account.tintColor = .white
        account.backgroundColor = UIColor(hex : 0x89A4C7)
        account.addTarget(self, action: #selector(accountButtonTapped), for : .touchUpInside)
        return account
    }()
    
    lazy var scheduleButton: UIButton = {
        let schedule = UIButton(type: .system)
        schedule.setTitle("시간표 관리", for: .normal)
        schedule.tintColor = .white
        schedule.backgroundColor = UIColor(hex : 0x89A4C7)
        schedule.addTarget(self, action: #selector(scheduleButtonTapped), for : .touchUpInside)
        return schedule
    }()
    
    lazy var friendButton: UIButton = {
        let friend = UIButton(type: .system)
        friend.setTitle("친구 관리", for: .normal)
        friend.tintColor = .white
        friend.backgroundColor = UIColor(hex : 0x89A4C7)
        friend.addTarget(self, action: #selector(friendButtonTapped), for : .touchUpInside)
        return friend
    }()
    
    lazy var userButton: UIButton = {
        let user = UIButton(type: .system)
        user.setTitle("이용 약관", for: .normal)
        user.tintColor = .white
        user.backgroundColor = UIColor(hex : 0x89A4C7)
        user.addTarget(self, action: #selector(userButtonTapped), for : .touchUpInside)
        return user
    }()
        
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
        self.addSubview(accountButton)
        self.addSubview(scheduleButton)
        self.addSubview(friendButton)
        self.addSubview(userButton)
        
    }
    
    
    override func setLayout() {
        circleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(25)
            $0.width.height.equalTo(50)
        }
        
        accountButton.snp.makeConstraints {
            $0.leading.equalTo(circleView.snp.leading)
            $0.top.equalTo(circleView.snp.bottom).offset(50)
            $0.width.equalTo(150)
        }
        
        scheduleButton.snp.makeConstraints {
            $0.leading.equalTo(circleView.snp.leading)
            $0.top.equalTo(accountButton.snp.bottom).offset(50)
            $0.width.equalTo(150)
        }
        
        friendButton.snp.makeConstraints {
            $0.leading.equalTo(circleView.snp.leading)
            $0.top.equalTo(scheduleButton.snp.bottom).offset(50)
            $0.width.equalTo(150)
        }
        
        userButton.snp.makeConstraints {
            $0.leading.equalTo(circleView.snp.leading)
            $0.top.equalTo(friendButton.snp.bottom).offset(50)
            $0.width.equalTo(150)
        }
    }
    
    @objc private func accountButtonTapped() {
            accountButtonAction?()
        }
    
    @objc private func friendButtonTapped() {
            friendButtonAction?()
        }
    
    @objc private func scheduleButtonTapped() {
            scheduleButtonAction?()
        }
    
    @objc private func userButtonTapped() {
            userButtonAction?()
        }
    
}

