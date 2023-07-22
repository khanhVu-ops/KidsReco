//
//  CategoryCellTableViewCell.swift
//  KidsReco
//
//  Created by Khanh Vu on 22/07/5 Reiwa.
//

import UIKit

class CategoryCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(item: String) {
        self.lbName.text = item
    }
    
}
