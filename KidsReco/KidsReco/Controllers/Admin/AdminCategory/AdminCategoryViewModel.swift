//
//  AdminCategoryViewModel.swift
//  KidsReco
//
//  Created by Khanh Vu on 22/07/5 Reiwa.
//

import Foundation
import RxSwift
import RxCocoa
class AdminCategoryViewModel: BaseViewModel {
    let listCategory = BehaviorRelay<[CategoryModel]>(value: [])
    
    func getListCategory() -> Observable<[CategoryModel]>{
        return FirebaseService.shared.getCategorys()
    }
}
