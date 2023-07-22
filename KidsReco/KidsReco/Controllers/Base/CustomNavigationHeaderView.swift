//
//  CustomNavigationHeaderView.swift
//  KidsReco
//
//  Created by mr.root on 7/20/23.
//

import UIKit
import SnapKit

class CustomNavigationHeaderView: UIView {
    
    lazy var leftButtonStackView = UIStackView()
    lazy var rightButtonStackView = UIStackView()
    
    lazy var titleLable: UILabel = {
       let title = UILabel()
        title.backgroundColor = .clear
        title.numberOfLines = 2
        title.textColor = .black
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    var titleValue: String? = nil {
        didSet {
            return titleLable.text = titleValue ?? ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    

   private func setupUI() {
        addSubview(titleLable)
        addSubview(leftButtonStackView)
        addSubview(rightButtonStackView)
       
       titleLable.setContentHuggingPriority(.defaultLow, for: .horizontal)
       titleLable.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
       titleLable.snp.makeConstraints { make in
           make.centerX.equalToSuperview()
           make.top.bottom.equalToSuperview()
           make.width.greaterThanOrEqualTo(200)
       }
       
       leftButtonStackView.backgroundColor = .clear
       leftButtonStackView.axis = .horizontal
       leftButtonStackView.alignment = .fill
       leftButtonStackView.distribution = .fillEqually
       leftButtonStackView.spacing = 8
       leftButtonStackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
       leftButtonStackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
       leftButtonStackView.snp.makeConstraints { make in
           make.leading.equalToSuperview().offset(16)
           make.top.bottom.equalToSuperview()
           make.trailing.lessThanOrEqualTo(titleLable.snp.leading).offset(-8)
       }
       
       rightButtonStackView.backgroundColor = .clear
       rightButtonStackView.axis = .horizontal
       rightButtonStackView.alignment = .fill
       rightButtonStackView.distribution = .fillEqually
       rightButtonStackView.spacing = 8
       rightButtonStackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
       rightButtonStackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
       
       rightButtonStackView.snp.makeConstraints { make in
           make.trailing.equalToSuperview().offset(-16)
           make.top.bottom.equalToSuperview()
           make.leading.greaterThanOrEqualTo(titleLable.snp.trailing).offset(8)
       }
       
       updateConstraintsIfNeeded()
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
   }()
   
    lazy var homeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
   }()
    
    func createCustomButton(with img: UIImage) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }
    
    func defaultConfig(isHomeButton: Bool = false) {
        leftButtonStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }
        rightButtonStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }
        
        if isHomeButton {
            rightButtonStackView.addArrangedSubview(homeButton)
        }
        updateConstraintsIfNeeded()
    }
    
    func customConfig(leftButtons: [UIButton], rightButtons: [UIButton]) {
        leftButtonStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }
        rightButtonStackView.arrangedSubviews.forEach { subView in
            subView.removeFromSuperview()
        }
        
        for leftButton in leftButtons {
            leftButtonStackView.addArrangedSubview(leftButton)
        }
        
        for rightButton in rightButtons {
            rightButtonStackView.addArrangedSubview(rightButton)
        }
        
        func setRightButtonImage(image: UIImage) {
            homeButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
    }
}
