//
//  Constants.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 17/07/5 Reiwa.
//

import Foundation
import UIKit
struct Constants {
    struct Color {
//        static let appPrimaryColor = UIColor(hexString: "#242121")
        static let appPrimaryColor = UIColor.white
        static let textColor = UIColor.black
        static let bgrItem = UIColor(hexString: "#F8F8F8")
        static let btnDisableColor = UIColor(hexString: "#403E3E")
    }
    
    struct Image {
        static let switchCameraSystem = UIImage(systemName: "camera.rotate.fill")!
        static let backButtonSystem = UIImage(systemName: "chevron.left")!
        static let downloadSystem = UIImage(systemName: "arrow.down.to.line.compact")!
        static let cancelSystem = UIImage(systemName: "xmark")!
        static let flashSlashSystem = UIImage(systemName: "bolt.slash.fill")!
        static let flashSystem = UIImage(systemName: "bolt.fill")!
        static let reloadSystem = UIImage(systemName: "arrow.counterclockwise")!
        static let checkMarkSystem = UIImage(systemName: "checkmark")!
    }
    
    struct L10n {
        static let commonErrorText = "Oops! Something went wrong. Please try again later!"
        static let commonErrorTimeoutText = "Oops! Request timeout. Please try again later!"
    }
}
