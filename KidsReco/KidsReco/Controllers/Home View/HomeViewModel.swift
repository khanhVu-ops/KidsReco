//
//  HomeViewModel.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import Foundation
import UIKit
class HomeViewModel: BaseViewModel {
    let listCategory: [CategoryModel] = [CategoryModel(icon: UIImage(named: "animals"), title: "Animals"),
                                         CategoryModel(icon: UIImage(named: "flowers"), title: "Flowers"),
                                         CategoryModel(icon: UIImage(named: "plants"), title: "Plants"),
                                         CategoryModel(icon: UIImage(named: "transports"), title: "Transports"),
    ]
}
