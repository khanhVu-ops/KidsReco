//
//  MainTabbarController.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import UIKit
import SnapKit

protocol MainTabbarDelegate: NSObject {
    func goToViewController(with index: Int, isHideTabbar: Bool)
}
class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customizedTabbar = CustomizedTabBar()
        self.setValue(customizedTabbar, forKey: "tabBar")
        self.delegate = self
        customizedTabbar.actionTapMiddleItem = { [weak self] index in
            self?.selectedIndex = index
            self?.tabBar.isHidden = true
        }
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .darkGray
        let homeVC = HomeViewController()
        let cameraVC = FilterViewController()
        cameraVC.tabbarDelegate = self
        let menuVC = MenuViewController()
        
        let firstItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        let secondItem = UITabBarItem(title: nil, image: nil, tag: 1)
        let thirdItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "square.grid.2x2.fill"), tag: 2)
        homeVC.tabBarItem = firstItem
        cameraVC.tabBarItem = secondItem
        menuVC.tabBarItem = thirdItem
        viewControllers = [homeVC, cameraVC, menuVC]
    }
}

extension MainTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let index = tabBarController.viewControllers?.firstIndex(of: viewController)  else {
            return
        }
        if index == 1 {
            tabBarController.tabBar.isHidden = true
        } else {
            tabBarController.tabBar.isHidden = false
        }
    }
}

extension MainTabbarController: MainTabbarDelegate {
    func goToViewController(with index: Int, isHideTabbar: Bool) {
        self.selectedIndex = index
        self.tabBar.isHidden = isHideTabbar
    }
}
