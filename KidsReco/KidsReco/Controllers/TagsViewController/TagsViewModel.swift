//
//  TagsViewModel.swift
//  KidsReco
//
//  Created by Khanh Vu on 23/07/5 Reiwa.
//

import Foundation
import RxSwift
import RxCocoa
class TagsViewModel: BaseViewModel {
    var listTags = BehaviorRelay<[TagModel]>(value: [])
    var title = BehaviorRelay<String>(value: "")
    var categoryID: String = ""
    var currentIndex = 2
    var initialContentOffset: CGPoint = .zero
    func getListTag() -> Observable<[TagModel]> {
        return FirebaseService.shared.getTags(categoryID: categoryID)
            .trackActivity(loading)
            .trackError(errorTracker)
            .asObservable()
    }
    
    func updateStatusFavorite(isFavorite: Bool) {
        let item = listTags.value[currentIndex]
        guard let tagID = item.id else {
            return
        }
        self.listTags.value[currentIndex].isFavorite = isFavorite
        FirebaseService.shared.updateStatusFavorite(categoryID: categoryID, tagID: tagID, isFavorite: isFavorite)
    }
    
    func preHandle(array: [TagModel]) -> [TagModel] {
        var newArray = array
        let count = array.count
        if array.count > 5 {
            newArray = [array[count-2], array[count-1]] + array + [array[0], array[1]]
        }
        return newArray
    }
}
