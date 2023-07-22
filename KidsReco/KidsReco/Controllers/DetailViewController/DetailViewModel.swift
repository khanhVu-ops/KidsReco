//
//  DetailViewModel.swift
//  KidsReco
//
//  Created by mr.root on 7/20/23.
//

import Foundation
import UIKit
import RxSwift

class DetailViewModel {
    var animalArrays = [AnimalModel]()
    var animalNameBehaviorSubject = BehaviorSubject<String?>(value: nil)
    
    func fetchData() {
        let animal1 = AnimalModel(name: "Lion", sound: "Meo meo", image: "animals")
        let animal2 = AnimalModel(name: "Flowers", sound: "Gao gao", image: "flowers")
        let animal3 = AnimalModel(name: "Plants", sound: "ngao ngao", image: "plants")
        
        animalArrays.append(animal1)
        animalArrays.append(animal2)
        animalArrays.append(animal3)
        
    }
    
    func getItem(with index: Int = 0)  {
        if index < 0 && index > animalArrays.count {
            print("vuongdv hehe")
            return
        }else {
            let item = animalArrays[index]
            animalNameBehaviorSubject.onNext(item.name ?? "")
        }
    }
}


