//
//  ViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Circle 설정
        let circleView = UIView()
        circleView.backgroundColor = .clear
        circleView.layer.cornerRadius = 50
        circleView.clipsToBounds = true
        
        // Image 설정
        let imageView = UIImageView()
        imageView.image = UIImage(named: "IMG_3399")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        // Text 설정 (닉네임과 학번)
        let usernameLabel = UILabel()
        usernameLabel.text = "김꽁 학생"  // 닉네임
        usernameLabel.textAlignment = .center
        
        let studentNumberLabel = UILabel()
        studentNumberLabel.text = "20233048"  // 학번
        studentNumberLabel.textAlignment = .center
        
        // Divider 설정
        let dividerView = UIView()
        dividerView.backgroundColor = .systemFill
        
        // StackView 설정
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, dividerView, studentNumberLabel])
        stackView.backgroundColor = .secondarySystemFill
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 3
        
        
        // 시간표 관리 버튼 설정
        let calendarButton = UIButton(type: .system)
        calendarButton.setTitle("시간표 관리", for: .normal)
        calendarButton.tintColor = .white
        calendarButton.backgroundColor = .systemGreen
        
        
        // 친구 관리 버튼 설정
        let friendButton = UIButton(type: .system)
        friendButton.setTitle("친구 관리", for: .normal)
        friendButton.tintColor = .white
        friendButton.backgroundColor = .systemGreen
        friendButton.addTarget(self, action: #selector(showFriendViewController), for : .touchUpInside)
        
        
        // 뷰에 추가
        circleView.addSubview(imageView)
        view.addSubview(circleView)
        view.addSubview(stackView)
        view.addSubview(calendarButton)
        view.addSubview(friendButton)
        
        // CircleView 제약
        circleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(50)
            make.width.height.equalTo(100)
        }
        
        // ImageView 제약 (Circle 내부)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // StackView 제약
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(circleView)  // Circle과 세로 중심 정렬
            make.leading.equalTo(circleView.snp.trailing).offset(20)
            make.width.equalTo(200)
        }
        
        // DividerView 제약
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)  // 높이 1로 설정
        }
        
        calendarButton.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(50)
            make.centerX.equalTo(circleView)
            make.width.equalTo(150)
        }
        
        friendButton.snp.makeConstraints { make in
            make.top.equalTo(calendarButton.snp.bottom).offset(25)
            make.centerX.equalTo(circleView)
            make.width.equalTo(150)
        }
    }
    
    @objc func showFriendViewController() {
        let friendViewController = FriendViewController()
        navigationController?.pushViewController(friendViewController, animated: true)
    }
}

