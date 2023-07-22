//
//  CustomItemView.swift
//  KidsReco
//
//  Created by mr.root on 7/20/23.
//

import UIKit
import SnapKit
import Foundation

class CustomItemView: UIView {
    lazy var button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
    }
    
}
