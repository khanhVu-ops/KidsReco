//
//  AdminViewController.swift
//  KidsReco
//
//  Created by Khanh Vu on 21/07/5 Reiwa.
//

import UIKit
import RxSwift

class AdminViewController: BaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imv: UIImageView!
    @IBOutlet weak var btnChooseImage: UIButton!
    @IBOutlet weak var tfTagName: UITextField!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var vBorderTagName: UIView!
    @IBOutlet weak var vTfTagName: UIView!
    let viewModel = AdminViewModel()
    var addCategorySuccess: ((String) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setUpUI() {
        self.btnBack.setImage(Constants.Image.backButtonSystem, for: .normal)
        self.imv.addConnerRadius(radius: 15)
        self.btnChooseImage.addConnerRadius(radius: 15)
        self.vBorderTagName.addConnerRadius(radius: 15)
        self.btnUpload.addConnerRadius(radius: 15)
        self.vTfTagName.addConnerRadius(radius: 5)
        self.vTfTagName.addBorder(borderWidth: 1, borderColor: .black)
        self.tfTagName.delegate = self
        
        self.addGestureDismissKeyboard(view: self.view)
    }
    
    override func setUpTap() {
        self.btnBack.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnBack.dimButton()
                self?.pop()
            })
            .disposed(by: disposeBag)
        
        self.btnChooseImage.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnChooseImage.dimButton()
                self?.openLibrary()
            })
            .disposed(by: disposeBag)
        
        self.btnUpload.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnUpload.dimButton()
                self?.handleUpload()
            })
            .disposed(by: disposeBag)
    }
    
    override func bindEvent() {
        self.trackShowToastError(viewModel)
        
    }
    
    func handleUpload() {
        guard let image = imv.image, let name = tfTagName.text else {
            return
        }
        self.viewModel.uploadImage(image: image, fileName: name)
            .subscribe(onNext: { [weak self] url in
                self?.viewModel.imageURL.accept(url)
            })
            .disposed(by: disposeBag)
    }

    override func bindViewModel() {
        self.viewModel.imageURL
            .subscribe(onNext: { [weak self] url in
                guard let name = self?.tfTagName.text, url != "", url != nil else {
                    return
                }
                if self?.viewModel.categoryID == nil {
                    self?.addCategory(url: url, name: name)
                } else {
                    self?.addTag(name: name, url: url)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addCategory(url: String, name: String) {
        self.viewModel.addCategory(name: name, url: url)
            .subscribe(onNext: { [weak self] id in
                if let addCategorySuccess = self?.addCategorySuccess {
                    self?.dismiss(animated: true, completion: nil)
                    addCategorySuccess(id)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addTag(name: String, url: String) {
        let item = TagModel(tagName: name, imageURL: url)
        return self.viewModel.addTag(item: item)
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    Toast.show("Add tag susscess")
                    self?.tfTagName.text = nil
                    self?.imv.image = nil
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func setImageFromImagePicker(image: UIImage) {
        self.imv.image = image
        
    }
    
}

extension AdminViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
