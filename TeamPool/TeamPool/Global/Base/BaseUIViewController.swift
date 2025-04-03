//
//  BaseUIViewController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import Foundation

import UIKit

class BaseUIViewController: UIViewController {

    // MARK: - Properties

    // MARK: - UI Components

    private var loadingIndicator: UIActivityIndicatorView?


    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.hideKeyboardWhenTappedAround()

        setupNavigationBar()
        setUI()
        setLayout()
        addTarget()
        setDelegate()
    }

    // MARK: - Custom Method

    func setUI() {}

    func setLayout() {}

    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 24)!]
        navigationController?.navigationBar.prefersLargeTitles = true

        //        let backButton: UIBarButtonItem = UIBarButtonItem()
        //        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    func showLoading() {
        if loadingIndicator == nil {
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.color = .gray
            indicator.hidesWhenStopped = true
            view.addSubview(indicator)
            indicator.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            loadingIndicator = indicator
        }

        loadingIndicator?.startAnimating()
        view.isUserInteractionEnabled = false
    }

    func hideLoading() {
        loadingIndicator?.stopAnimating()
        view.isUserInteractionEnabled = true
    }

    // MARK: - Action Method

    func addTarget() {}

    // MARK: - delegate Method

    func setDelegate() {}
}



extension UIViewController {

    /// 키보드 위 화면 터치 시, 키보드 내리기
    func hideKeyboardWhenTappedAround() {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tapped.cancelsTouchesInView = false
        view.addGestureRecognizer(tapped)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
