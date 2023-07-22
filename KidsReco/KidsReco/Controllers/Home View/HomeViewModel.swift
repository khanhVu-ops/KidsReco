//
//  HomeViewModel.swift
//  FlowerClassification
//
//  Created by Khanh Vu on 18/07/5 Reiwa.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class HomeViewModel: BaseViewModel {
    let listCategory = BehaviorRelay<[CategoryModel]>(value: [])
    
    func getListCategory() -> Observable<[CategoryModel]> {
        return FirebaseService.shared.getCategorys()
    }
}
