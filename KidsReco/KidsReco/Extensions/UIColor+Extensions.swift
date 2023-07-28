//
//  UIColor+Extensions.swift
//  ChatApp
//
//  Created by Vu Khanh on 06/03/2023.
//

import Foundation
import UIKit
extension UIColor {
    func toHexString() -> String {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        // Get the RGBA values of the color
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let redInt = Int(red * 255.0)
            let greenInt = Int(green * 255.0)
            let blueInt = Int(blue * 255.0)
            
            // Create the hex string in the format "#RRGGBB"
            return String(format: "#%02X%02X%02X", redInt, greenInt, blueInt)
        }
        
        // Return a default hex string if conversion fails
        return "#000000"
    }
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
