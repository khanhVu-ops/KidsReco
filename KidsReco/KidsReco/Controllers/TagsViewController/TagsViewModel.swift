//
//  TagsViewModel.swift
//  KidsReco
//
//  Created by Khanh Vu on 23/07/5 Reiwa.
//

import Foundation
import RxSwift
import RxCocoa
import AVFoundation

class TagsViewModel: BaseViewModel {
    var listTags = BehaviorRelay<[TagModel]>(value: [])
    var title = BehaviorRelay<String>(value: "")
    var categoryID: String = ""
    var currentIndex = 2
    var indexFirstTag = 2
    var indexLastTag = 0
    var initialContentOffset: CGPoint = .zero
    
    private lazy var synthesizer = AVSpeechSynthesizer()

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
        if count > 2 {
            newArray = [array[count-2], array[count-1]] + array + [array[0], array[1]]
        }
        self.indexLastTag = newArray.count - 3
        return newArray
    }
    
    func scrollToIndex(collectionView: UICollectionView, index: Int, isAnimate: Bool) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: isAnimate)
    }
    
    func handleBtnDrag(collectionView: UICollectionView, isNext: Bool, isAnimate: Bool = true) {
        self.currentIndex += isNext ? 1 : -1
        self.scrollToIndex(collectionView: collectionView, index: self.currentIndex, isAnimate: isAnimate)
    }
    
    func setUpSpeaker() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            
        } catch let error {
            Toast.show("This error message from SpeechSynthesizer \(error.localizedDescription)")
        }
    }
    
    func speakText() {
        guard let tagName = self.listTags.value[self.currentIndex].tagName else {
            return
        }
        let utterance = AVSpeechUtterance(string: tagName)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}
