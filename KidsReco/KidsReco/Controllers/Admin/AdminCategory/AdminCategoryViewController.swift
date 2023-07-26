//
//  AdminCategoryViewController.swift
//  KidsReco
//
//  Created by Khanh Vu on 22/07/5 Reiwa.
//

import UIKit

class AdminCategoryViewController: BaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var tbvListCategory: UITableView!
    
    let viewModel = AdminCategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpUI() {
        tbvListCategory.delegate = self
        tbvListCategory.dataSource = self
        tbvListCategory.register(CategoryCellTableViewCell.nibClass, forCellReuseIdentifier: CategoryCellTableViewCell.nibNameClass)
        btnBack.setImage(Constants.Image.backButtonSystem, for: .normal)
    }
    
    override func setUpTap() {
        btnBack.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnBack.dimButton()
                self?.pop()
            })
            .disposed(by: disposeBag)
        btnNew.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnNew.dimButton()
                let vc = AdminViewController()
                vc.addCategorySuccess = { [weak self] id in
                    DispatchQueue.main.async {
                        Toast.show("add success")
                    }
                }
                self?.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

    override func bindViewModel() {
        self.viewModel.listCategory
            .subscribe(onNext: { [weak self] _ in
                self?.tbvListCategory.reloadData()
            })
            .disposed(by: disposeBag)
        
        self.viewModel.getListCategory()
            .subscribe(onNext: { [weak self] value in
                self?.viewModel.listCategory.accept(value)
            })
            .disposed(by: disposeBag)
    }
}

extension AdminCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listCategory.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCellTableViewCell.nibNameClass, for: indexPath) as! CategoryCellTableViewCell
        let item = self.viewModel.listCategory.value[indexPath.item]
        cell.configure(item: item.categoryName ?? "No name")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.listCategory.value[indexPath.item]
        let vc = AdminViewController()
        vc.viewModel.categoryID = item.id
        self.push(vc)
    }
}
