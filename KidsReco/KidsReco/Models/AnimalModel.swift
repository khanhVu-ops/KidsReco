//
//  AnimalModel.swift
//  KidsReco
//
//  Created by mr.root on 7/20/23.
//

import Foundation

class AnimalModel {
    var name: String?
    var sound: String?
    var image: String?
    
    init() {}
    
    convenience init(name: String?, sound: String?, image: String?) {
        self.init()
        self.name = name
        self.sound = sound
        self.image = image
    }
}
