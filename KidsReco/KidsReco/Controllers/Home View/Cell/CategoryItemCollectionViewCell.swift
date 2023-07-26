//
//  HomeCollectionViewCell.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import UIKit

class CategoryItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vBorderCell: UIView!
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
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.vBorderCell.backgroundColor = .white
        self.vBorderCell.addShadowwWith(radius: 15, borderColor: .gray, borderWidth: 1, shadowColor: .black, shadowOpacity: 0.3, shadowRadius: 4, shadowOffset: CGSize(width: 2, height: 2))
        self.lbTitle.textColor = Constants.Color.textColor

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
