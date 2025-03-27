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
    let apperance = UITabBarAppearance()

    lazy var homeNavigationViewController = UINavigationController(rootViewController: homeViewController)
    lazy var calendarNavigationViewController = UINavigationController(rootViewController: calendarViewController)
    lazy var myPageNavigationController = UINavigationController(rootViewController: myPageViewController)

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
                                                   calendarNavigationViewController,
                                                   myPageNavigationController]
        self.setViewControllers(viewControllers, animated: false)
    }

    private func setViewController() {
        homeViewController.tabBarItem = setTabbarItem(imageName: "house", selectedImageName: "house.fill")
        calendarViewController.tabBarItem = setTabbarItem(imageName: "calendar", selectedImageName: "calendar.fill")
        myPageViewController.tabBarItem = setTabbarItem(imageName: "person", selectedImageName: "person.fill")
    }

    private func setTabbarItem(imageName: String, selectedImageName: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: nil,
                                      image: UIImage(systemName: imageName),
                                      selectedImage: UIImage(systemName: selectedImageName))
        return tabBarItem
    }
}
