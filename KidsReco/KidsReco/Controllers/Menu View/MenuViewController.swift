//
//  MenuViewController.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import UIKit
import RxSwift
import RxCocoa
class MenuViewController: BaseViewController {

    @IBOutlet weak var vShare: UIView!
    @IBOutlet weak var vTermsAndConditions: UIView!
    @IBOutlet weak var vLastestVersion: UIView!
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnTermsAndConditions: UIButton!
    @IBOutlet weak var btnLastestVersion: UIButton!
    @IBOutlet weak var lbLastestVersion: UILabel!
    
    let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setUpUI() {
        self.vShare.addConnerRadius(radius: 20)
        self.vShare.backgroundColor = Constants.Color.bgrItem
        self.vTermsAndConditions.addConnerRadius(radius: 20)
        self.vTermsAndConditions.backgroundColor = Constants.Color.bgrItem
        self.vLastestVersion.addConnerRadius(radius: 20)
        self.vLastestVersion.backgroundColor = Constants.Color.bgrItem
        self.lbLastestVersion.text = self.viewModel.getLastestVersion()
    }
    
    override func setUpTap() {
        self.btnShare.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnShare.dimButton()
                
            })
            .disposed(by: disposeBag)
        
        self.btnTermsAndConditions.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnShare.dimButton()
                
            })
            .disposed(by: disposeBag)
        
        self.btnLastestVersion.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnShare.dimButton()
                
            })
            .disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        
    }
}
