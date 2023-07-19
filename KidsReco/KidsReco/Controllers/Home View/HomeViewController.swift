//
//  HomeViewController.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var cltvListCategory: UICollectionView!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setUpUI() {
        self.view.backgroundColor = Constants.Color.appPrimaryColor
        self.lbTitle.textColor = Constants.Color.textColor
        self.lbTitle.text = "KidsReco"
        self.cltvListCategory.register(CategoryItemCollectionViewCell.nibClass, forCellWithReuseIdentifier: CategoryItemCollectionViewCell.nibNameClass)
        self.cltvListCategory.dataSource = self
        self.cltvListCategory.delegate = self
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItemCollectionViewCell.nibNameClass, for: indexPath) as! CategoryItemCollectionViewCell
        cell.configure(item: self.viewModel.listCategory[indexPath.item])
        return cell
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.cltvListCategory.frame.width - 20)/2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
