//
//  CategoryModel.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import Foundation
import UIKit

class CategoryModel {
    var imvIcon: UIImage?
    var title: String?
    
    init() {}
    
    convenience init(icon: UIImage?, title: String?) {
        self.init()
        self.imvIcon = icon
        self.title = title
    }
}
