//
//  HomeCollectionViewCell.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import UIKit

class CategoryItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imvCategory: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codes
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupUI() {
        self.lbTitle.textColor = Constants.Color.textColor
        self.backgroundColor = Constants.Color.bgrItem
        self.addConnerRadius(radius: 15)
    }

    func configure(item: CategoryModel) {
        self.lbTitle.text = item.categoryName
        self.imvCategory.setImage(urlString: item.imageURL, placeHolder: Constants.Image.defaultImage)
    }
}
