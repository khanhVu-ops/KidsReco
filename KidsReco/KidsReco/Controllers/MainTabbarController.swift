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

    private lazy var imvScan: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "ic_scan")?.resize(with: CGSize(width: 25, height: 25))
//        imv.contentMode = .scaleAspectFit
        imv.contentMode = .scaleAspectFill
        
        return imv
    }()
    
    private lazy var vLine: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.tabBar.addSubview(vLine)
        vLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(0.3)
        }
        
        self.tabBar.tintColor = .blue
        self.tabBar.unselectedItemTintColor = .darkGray
        // Xác định các tab bar items
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

        tabBar.addSubview(imvScan)
        imvScan.addConnerRadius(radius: 20)
        imvScan.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.width.height.equalTo(40)
        }
        imvScan.backgroundColor = Constants.Color.bgrItem
        tabBar.bringSubviewToFront(imvScan)
        viewControllers = [homeVC, cameraVC, menuVC]
        // Do any additional setup after loading the view.
    }
}

extension MainTabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Lấy index của view controller đã chọn
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
            // Kiểm tra nếu index của tab bar item đã chọn là 1
            if index == 1 {
                // Ẩn tab bar
                tabBarController.tabBar.isHidden = true
            } else {
                // Hiển thị tab bar
                tabBarController.tabBar.isHidden = false
            }
        }
    }
}

extension MainTabbarController: MainTabbarDelegate {
    func goToViewController(with index: Int, isHideTabbar: Bool) {
        self.selectedIndex = index
        self.tabBar.isHidden = isHideTabbar
    }
}
