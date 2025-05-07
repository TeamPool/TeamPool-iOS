//
//  PoolViewController.swift
//  TeamPool
//
//  Created by 성현주 on 5/7/25.
//

import UIKit
import SnapKit

final class PoolViewController: BaseUIViewController {

    // MARK: - Constants

    // MARK: - UI Components
    private let categoryTabBar = CategoryTabBarView()
    private let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )

    // MARK: - Constraints
    private var indicatorTopConstraint: Constraint?
    private var tabBarTopConstraint: Constraint?

    // MARK: - State
    private var currentIndex = 0

    // MARK: - View Controllers
    private lazy var viewControllers: [UIViewController] = [
        HomeViewController(),
        UsaintLogInViewController(),
        MyPageViewController()
    ]

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - UI Setup
    override func setUI() {
        addChild(pageViewController)

        view.addSubviews(
            categoryTabBar,
            pageViewController.view
        )

        pageViewController.setViewControllers(
            [viewControllers.first].compactMap { $0 },
            direction: .forward,
            animated: false
        )

        pageViewController.didMove(toParent: self)
    }

    override func setLayout() {
        categoryTabBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }

        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(categoryTabBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func setDelegate() {
        categoryTabBar.delegate = self
        pageViewController.delegate = self
        pageViewController.dataSource = self

    }
}

// MARK: - PageView, TabBar Delegate
extension PoolViewController: CategoryTabBarViewDelegate {
    func didSelectCategory(index: Int) {
        let direction: UIPageViewController.NavigationDirection = index > currentIndex ? .forward : .reverse

        currentIndex = index

        pageViewController.setViewControllers(
            [viewControllers[index]],
            direction: direction,
            animated: true
        )
    }
}

extension PoolViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index > 0 else { return nil }
        return viewControllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController), index < viewControllers.count - 1 else { return nil }
        return viewControllers[index + 1]
    }
}

extension PoolViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard completed,
              let currentVC = pageViewController.viewControllers?.first,
              let index = viewControllers.firstIndex(of: currentVC) else { return }

        currentIndex = index
        categoryTabBar.moveIndicator(to: index)
    }
}

