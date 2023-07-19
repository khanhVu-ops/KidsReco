//
//  ImageCache.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 19/07/5 Reiwa.
//

import Foundation
import UIKit
class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
