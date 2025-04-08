//
//  BaseAlertViewController.swift
//  TeamPool
//
//  Created by 성현주 on 4/2/25.
//

import UIKit

final class BaseAlertViewController {

    static func showAlert(
        on viewController: UIViewController,
        title: String,
        message: String,
        confirmTitle: String = "확인",
        cancelTitle: String? = nil,
        confirmHandler: (() -> Void)? = nil,
        cancelHandler: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // 확인 버튼
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirmHandler?()
        }
        alert.addAction(confirmAction)

        // 취소 버튼이 있는 경우
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelHandler?()
            }
            alert.addAction(cancelAction)
        }

        viewController.present(alert, animated: true)
    }
}
