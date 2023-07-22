//
//  CategoryModel.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import Foundation
import UIKit

//class CategoryModels {
//    var imvIcon: UIImage?
//    var title: String?
//
//    init() {}
//
//    convenience init(icon: UIImage?, title: String?) {
//        self.init()
//        self.imvIcon = icon
//        self.title = title
//    }
//}

class CategoryModel: NSObject, JsonInitObject {
    var id: String?
    var categoryName: String?
    var imageURL: String?
    convenience init(id: String? = nil, categoryName: String, imageURL: String? = nil) {
        self.init()
        self.id = id
        self.categoryName = categoryName
        self.imageURL = imageURL
    }
    
    
    required convenience init(json: [String : Any]) {
        self.init()
        for (key, value) in json {
            if key == "id", let wrapValue = value as? String {
                self.id = wrapValue
            }
            if key == "categoryName", let wrapValue = value as? String {
                self.categoryName = wrapValue
            }
            if key == "imageURL", let wrapValue = value as? String {
                self.imageURL = wrapValue
            }
        }
    }
    
    func convertToDictionary() -> [String: Any] {
        return  [
            "id": self.id ?? "",
            "categoryName": categoryName ?? "",
            "imageURL": imageURL ?? "",
        ] as [String : Any]
    }
}

