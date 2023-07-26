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
        self.layer.cornerRadius = 20
        self.imvTag.contentMode = .scaleAspectFit
        self.imvTag.backgroundColor = .white
        self.imvTag.addShadowwWith(radius: 20, borderColor: .gray, borderWidth: 1, shadowColor: .black, shadowOpacity: 0.3, shadowRadius: 4, shadowOffset: CGSize(width: 2, height: 2))
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           // Make sure to update the shadow path when the cell's layout changes
           layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
       }
    
    func configure(item: TagModel) {
        self.imvTag.setImage(urlString: item.imageURL, placeHolder: Constants.Image.defaultImage)
    }

}
