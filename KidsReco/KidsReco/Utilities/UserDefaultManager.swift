//
//  UserDefaultManager.swift
//  KidsReco
//
//  Created by Khanh Vu on 28/07/5 Reiwa.
//

import Foundation
import UIKit

class UserDefaultManager {
    static let shared = UserDefaultManager()
    let userDefault = UserDefaults.standard
    
    func setFavorite(newArray: [Bool], for key: String) {
        userDefault.setValue(newArray, forKey: key)
    }
    
    func getFavorite(for key: String) -> [Bool] {
        return userDefault.array(forKey: key) as? [Bool] ?? []
    }
}

