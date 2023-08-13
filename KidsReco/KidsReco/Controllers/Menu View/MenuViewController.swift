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
    @IBOutlet weak var vAdmin: UIView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnTermsAndConditions: UIButton!
    @IBOutlet weak var btnLastestVersion: UIButton!
    @IBOutlet weak var btnAdmin: UIButton!
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
        self.vAdmin.backgroundColor = Constants.Color.bgrItem
        self.vAdmin.addConnerRadius(radius: 20)
        self.vAdmin.isHidden = true
    }
    
    override func setUpTap() {
        self.btnShare.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnShare.dimButton()
                Toast.show("Coming soon!")
            })
            .disposed(by: disposeBag)
        
        self.btnTermsAndConditions.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnTermsAndConditions.dimButton()
                let termVC = TermViewController()
                let navTerm = UINavigationController(rootViewController: termVC)
                self?.present(navTerm, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        self.btnLastestVersion.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnLastestVersion.dimButton()
            })
            .disposed(by: disposeBag)
        
        self.btnAdmin.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnAdmin.dimButton()
                let vc = AdminCategoryViewController()
                self?.push(vc)
            })
            .disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        
    }
}
