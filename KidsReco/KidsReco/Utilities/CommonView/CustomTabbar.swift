//
//  CustomTabbar.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import Foundation
import UIKit
import SnapKit

class CustomTabBar: UIView {
    
    private let scanIcon: UIImageView = {
        let imv = UIImageView()
//        imv.backgroundColor = .systemBlue
        imv.image = UIImage(named: "ic_scan")
        return imv
    }()
    
    private var tabBarItems = [UITabBarItem]()
    private var selectedTabBarItemIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        addSubview(scanIcon)
        
        // Xác định ràng buộc cho circleView
        scanIcon.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(scanIcon.snp.height)
            make.centerX.equalToSuperview()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Xác định các nút tab bar item
        let tabBarButtonWidth = bounds.width / CGFloat(tabBarItems.count)
        self.scanIcon.circleClip()
        for (index, item) in tabBarItems.enumerated() {
            let tabBarButton = CustomTabbarItem()
            tabBarButton.btnTapView.tag = index
            tabBarButton.btnTapView.addTarget(self, action: #selector(tabBarButtonTapped(_:)), for: .touchUpInside)
            tabBarButton.frame = CGRect(x: CGFloat(index) * tabBarButtonWidth, y: 0, width: tabBarButtonWidth, height: bounds.height)
            tabBarButton.setTitle(title: item.title, icon: item.image)
            
            if index == selectedTabBarItemIndex {
                tabBarButton.setSelectColor(color: .blue)
            } else {
                tabBarButton.setSelectColor(color: .lightGray)
            }
            
            addSubview(tabBarButton)
        }
    }
    
    @objc private func tabBarButtonTapped(_ sender: UIButton) {
        selectedTabBarItemIndex = sender.tag
        setNeedsLayout()
        
        // Chuyển đổi đến view controller tương ứng với tab bar item được chọn
        if let tabBarViewController = window?.rootViewController as? MainTabbarController {
            tabBarViewController.selectedIndex = selectedTabBarItemIndex
        }
    }
    
    func setTabBarItems(_ items: [UITabBarItem]) {
        tabBarItems = items
    }
}

class CustomTabbarItem: UIView {
    private lazy var icon: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "ic_home")
        return imv
    }()
    
    private lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var stv: UIStackView = {
        let stv = UIStackView()
        [icon, lbTitle].forEach { sub in
            stv.addArrangedSubview(sub)
        }
        stv.axis = .vertical
        stv.alignment = .center
        stv.distribution = .fill
        stv.spacing = 0
        return stv
    }()
    
    lazy var btnTapView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(stv)
        [stv, btnTapView].forEach { sub in
            self.addSubview(sub)
        }
        
        self.icon.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        self.stv.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        self.btnTapView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setTitle(title: String?, icon: UIImage?) {
        self.icon.image = icon
        self.lbTitle.text = title
    }
    
    func setSelectColor(color: UIColor) {
        self.icon.tintColor = color
        self.lbTitle.textColor = color
    }
    
}
