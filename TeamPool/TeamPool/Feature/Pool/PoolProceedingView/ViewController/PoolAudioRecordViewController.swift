//
//  PoolAudioRecordViewController.swift
//  TeamPool
//
//  Created by 성현주 on 5/11/25.
//

import UIKit

import Speech

final class PoolAudioRecordViewController: BaseUIViewController {

    // MARK: - Properties


    // MARK: - UI Components

    private let poolAudioRecordView = PoolAudioRecordView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Custom Method
    override func setUI() {
        view.addSubview(poolAudioRecordView)
    }

    override func setLayout() {
        poolAudioRecordView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - Action Method

}

extension PoolAudioRecordViewController: SFSpeechRecognizerDelegate {

}
