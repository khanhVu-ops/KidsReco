//
//  AdminViewModel.swift
//  KidsReco
//
//  Created by Khanh Vu on 22/07/5 Reiwa.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AdminViewModel: BaseViewModel {
    var bottomConstant: CGFloat = 0.0
    var categoryID: String?
    var imageURL = BehaviorRelay<String>(value: "")
    func addCategory(name: String, url: String) -> Observable<String>{
        let item = CategoryModel(categoryName: name, imageURL: url)
        return FirebaseService.shared.addCategory(item: item)
            .trackActivity(loading)
            .trackError(errorTracker)
            .asObservable()
    }
    
    func addTag(item: TagModel) -> Observable<String> {
        return FirebaseService.shared.addTag(item: item, categoryID: categoryID!)
    }
    
    func uploadImage(image: UIImage, fileName: String) -> Observable<String> {
        return FirebaseService.shared.uploadImage(image: image, fileName: fileName)
            .trackActivity(loading)
            .trackError(errorTracker)
            .asObservable()
    }
    
}
