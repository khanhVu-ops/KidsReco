//
//  TagModel.swift
//  KidsReco
//
//  Created by Khanh Vu on 22/07/5 Reiwa.
//

import Foundation

class TagModel: NSObject, JsonInitObject {
    var id: String?
    var tagName: String?
    var imageURL: String?
    var isFavorite: Bool?
    
    convenience init(id: String? = nil, tagName: String, imageURL: String? = nil, isFavorite: Bool = false) {
        self.init()
        self.id = id
        self.tagName = tagName
        self.imageURL = imageURL
        self.isFavorite = isFavorite
    }
    
    required convenience init(json: [String : Any]) {
        self.init()
        for (key, value) in json {
            if key == "id", let wrapValue = value as? String {
                self.id = wrapValue
            }
            if key == "tagName", let wrapValue = value as? String {
                self.tagName = wrapValue
            }
            if key == "imageURL", let wrapValue = value as? String {
                self.imageURL = wrapValue
            }
            if key == "isFavorite", let wrapValue = value as? Bool {
                self.isFavorite = wrapValue
            }
        }
    }
    
    func convertToDictionary() -> [String: Any] {
        return  [
            "id": self.id ?? "",
            "tagName": tagName ?? "",
            "imageURL": imageURL ?? "",
            "isFavorite": isFavorite ?? false
        ] as [String : Any]
    }
}
