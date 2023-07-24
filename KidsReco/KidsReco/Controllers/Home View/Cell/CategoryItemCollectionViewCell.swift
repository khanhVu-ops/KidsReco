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
    var actionOpenDetailTapped: ((String, String) -> Void)?
    var item: CategoryModel?
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
        self.item = item
        self.lbTitle.text = item.categoryName
        self.imvCategory.setImage(urlString: item.imageURL, placeHolder: Constants.Image.defaultImage)
    }
    @IBAction func btnDetailTapped(_ sender: Any) {
        guard let categoryID = item?.id, let title = item?.categoryName, let actionOpenDetailTapped = actionOpenDetailTapped else {
            return
        }
        actionOpenDetailTapped(categoryID, title)
    }
}
