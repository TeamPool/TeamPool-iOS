//
//  PoolAudioRecordView.swift
//  TeamPool
//
//  Created by 성현주 on 5/11/25.
//

import UIKit

import SnapKit

class PoolAudioRecordView: BaseUIView {

    // MARK: - UI Components
    let recordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        return button
    }()



    // MARK: - Life Cycle

    // MARK: - Custom Method

    override func setUI() {
        self.addSubview(recordButton)
    }

    override func setLayout() {
        recordButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(56)
        }


    }

}

