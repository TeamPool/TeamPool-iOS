//
//  BaseTabBarController.swift
//  TeamPool
//
//  Created by 성현주 on 3/26/25.
//

import UIKit

class BaseTabBarController: UITabBarController {

    // MARK: - UI Components

    let homeViewController = HomeViewController()
    let calendarViewController = CalendarViewController()
    let myPageViewController = MyPageViewController()
    let addPoolViewController = AddPoolViewController()
    let apperance = UITabBarAppearance()

    lazy var homeNavigationViewController = UINavigationController(rootViewController: homeViewController)
    lazy var calendarNavigationViewController = UINavigationController(rootViewController: calendarViewController)
    lazy var myPageNavigationController = UINavigationController(rootViewController: myPageViewController)
    lazy var addPoolNavigationController = UINavigationController(rootViewController: addPoolViewController)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBar()
        setViewController()
    }

    // MARK: - Custom Method

    private func setTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.itemPositioning = .automatic
        let viewControllers: [UIViewController] = [homeNavigationViewController,
                                                   addPoolViewController,
                                                   calendarNavigationViewController,
                                                   myPageNavigationController]
        self.setViewControllers(viewControllers, animated: false)
    }

    //TODO: - icon fill empty 반영
    private func setViewController() {
        homeViewController.tabBarItem = setTabbarItem(image: ImageLiterals.homeFill, selectedImage: ImageLiterals.homeFill)
        addPoolViewController.tabBarItem = setTabbarItem(image: ImageLiterals.pool, selectedImage: ImageLiterals.pool)
        calendarViewController.tabBarItem = setTabbarItem(image: ImageLiterals.calendar, selectedImage: ImageLiterals.calendar)
        myPageViewController.tabBarItem = setTabbarItem(image: ImageLiterals.myPage, selectedImage: ImageLiterals.myPage)
    }

    private func setTabbarItem(image: UIImage, selectedImage: UIImage) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        return tabBarItem
    }
}
