//
//  ImageCollectionViewCell.swift
//  KidsReco
//
//  Created by mr.root on 7/20/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var subview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subview.backgroundColor = Constants.Color.bgrItem
        subview.setCornerRadius(cornerRadius: 20)
    }
    
    func bindData(with data: AnimalModel) {
        DispatchQueue.main.async {
            self.img.image = UIImage(named: data.image ?? "")
        }
    }

}
