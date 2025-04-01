//
//  HomeView.swift
//  TeamPool
//
//  Created by 성현주 on 4/1/25.
//

import UIKit

import SnapKit

class HomeView: BaseUIView {

    // MARK: - UI Components

    lazy var exampleButton: UIButton = {
        let button = UIButton()
        button.setTitle("example", for: .normal)
        button.backgroundColor = .red
        return button
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
        self.addSubview(exampleButton)

    }

    override func setLayout() {
        exampleButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.center.equalToSuperview()
            $0.height.equalTo(50)
        }
    }

}

