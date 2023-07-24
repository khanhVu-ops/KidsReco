//
//  TagCollectionViewCell.swift
//  KidsReco
//
//  Created by Khanh Vu on 23/07/5 Reiwa.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imvTag: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }
    
    func setUpView() {
        self.imvTag.contentMode = .scaleAspectFill
        self.addConnerRadius(radius: 20)
        self.addBorder(borderWidth: 1, borderColor: .darkGray)
        imvTag.backgroundColor = Constants.Color.bgrItem
    }
    
    func configure(item: TagModel) {
        self.imvTag.setImage(urlString: item.imageURL, placeHolder: Constants.Image.defaultImage)
    }

}
