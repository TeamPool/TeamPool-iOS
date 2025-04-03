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

    //TODO: - icon fill empty 반영
    private func setViewController() {
        homeViewController.tabBarItem = setTabbarItem(image: ImageLiterals.homeFill, selectedImage: ImageLiterals.homeFill)
        calendarViewController.tabBarItem = setTabbarItem(image: ImageLiterals.calendar, selectedImage: ImageLiterals.calendar)
        myPageViewController.tabBarItem = setTabbarItem(image: ImageLiterals.myPage, selectedImage: ImageLiterals.myPage)
    }

    private func setTabbarItem(image: UIImage, selectedImage: UIImage) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        return tabBarItem
    }
}

extension UITabBar {
    func changeTabBar(hidden:Bool, animated: Bool){
        if self.isHidden == hidden { return }
        let frame = self.frame
        let offset = hidden ? frame.size.height: -frame.size.height
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        self.isHidden = false

        UIView.animate(withDuration: duration, animations: {
            self.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: { (true) in
            self.isHidden = hidden
        })

    }

}
