//
//  FirebaseService.swift
//  VideoChatApp
//
//  Created by Khanh Vu on 12/06/5 Reiwa.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import FirebaseFirestore

final class FirebaseService: BaseFirebaseService {
    static let shared = FirebaseService()

    let disposeBag = DisposeBag()
    
    func addCategory(item: CategoryModel) ->  Observable<String> {
        let path = fireStore.collection(categoryClt).document()
        item.id = path.documentID
        let data = item.convertToDictionary()
        return self.rxSetData(path: path, data: data)
    }
    
    func addTag(item: TagModel, categoryID: String) ->  Observable<String> {
        let path = fireStore.collection(categoryClt).document(categoryID).collection(tagsClt).document()
        item.id = path.documentID
        let data = item.convertToDictionary()
        return self.rxSetData(path: path, data: data)
    }
    
    func getCategorys() -> Observable<[CategoryModel]> {
        let path = fireStore.collection(categoryClt)
        return self.rxRequestCollection(path: path, isListener: true)
    }
    
    func getTags(categoryID: String) -> Observable<[TagModel]> {
        let path = fireStore.collection(categoryClt).document(categoryID).collection(tagsClt)
        return self.rxRequestCollection(path: path, isListener: false)
    }
    
    func uploadImage(image: UIImage?, fileName: String?) -> Observable<String> {
        return Observable.create { observable in
            self.uploadImage(image: image, fileName: fileName) { url in
                observable.onNext(url)
                observable.onCompleted()
            } failure: { message in
                observable.onError(AppError(code: .firebase, message: message))
            }
            return Disposables.create()
        }
    }
    
    func updateImage(categoryID: String?, tagID: String?, url: String) {
        guard let categoryID = categoryID else {
            return
        }
        if let tagID = tagID {
            let ref = fireStore.collection(categoryClt).document(categoryID).collection(tagsClt).document(tagID)
            ref.updateData(["imageURL": url])
        } else {
            let ref = fireStore.collection(categoryClt).document(categoryID)
            ref.updateData(["imageURL": url])
        }
    }
    
    func updateStatusFavorite(categoryID: String, tagID: String, isFavorite: Bool) {
        let ref = fireStore.collection(categoryClt).document(categoryID).collection(tagsClt).document(tagID)
        ref.updateData(["isFavorite": isFavorite])
    }
}
