//
//  CustomCaptureButton.swift
//  IntergrateMLModel
//
//  Created by Khanh Vu on 29/03/5 Reiwa.
//

import UIKit
import SnapKit
class CustomCaptureButton: UIView {

    private lazy var vCenter: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var btnEnter: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(didEnter), for: .touchUpInside)
        return btn
    }()
    
    var actionTapEnter: (()->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(frame: CGRect) {
        [vCenter, btnEnter].forEach { sub in
            self.addSubview(sub)
        }
        
        vCenter.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(2)
        }
        
        btnEnter.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(-2)
        }
        
        self.addBorder(borderWidth: 3, borderColor: .white)
        self.backgroundColor = .clear
        
        vCenter.addBorder(borderWidth: 6, borderColor: .black)
        self.backgroundColor = .white
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addConnerRadius(radius: frame.width/2)
        btnEnter.addConnerRadius(radius: btnEnter.frame.width/2)
        vCenter.addConnerRadius(radius: vCenter.frame.width/2)
        
    }
    
    func animateWhenPushEnter() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.vCenter.layer.borderWidth = 12
        } completion: { [weak self] _ in
            self?.vCenter.layer.borderWidth = 6
        }
    }
    
    @objc func didEnter() {
        if let actionTapEnter = actionTapEnter {
            actionTapEnter()
        }
    }
    
    func showCheckMark(isShow: Bool) {
        isShow ? btnEnter.setImage(Constants.Image.checkMarkSystem.resize(with: CGSize(width: 30, height: 30)), for: .normal) : btnEnter.setImage(nil, for: .normal)
        btnEnter.backgroundColor = isShow ? .white : .clear
    }
}
