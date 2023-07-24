//
//  TagsViewController.swift
//  KidsReco
//
//  Created by Khanh Vu on 23/07/5 Reiwa.
//

import UIKit
import RxGesture
import AVFoundation
class TagsViewController: BaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var cltvListTags: UICollectionView!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var btnSpeaker: UIButton!
    @IBOutlet weak var btnWiki: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var vTagName: UIView!
    @IBOutlet weak var lbTagName: UILabel!
    
    let viewModel = TagsViewModel()
    let synthesizer = AVSpeechSynthesizer()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setUpUI() {
        self.cltvListTags.backgroundColor = .clear
        self.cltvListTags.register(TagCollectionViewCell.nibClass, forCellWithReuseIdentifier: TagCollectionViewCell.nibNameClass)
        self.cltvListTags.dataSource = self
        self.cltvListTags.delegate = self
        self.btnBack.setImage(Constants.Image.backButtonSystem, for: .normal)
        self.btnPrevious.setImage(Constants.Image.backButtonSystem, for: .normal)
        self.btnNext.setImage(Constants.Image.nextSystem, for: .normal)
        self.btnSpeaker.setImage(Constants.Image.speakerSystem, for: .normal)
        self.btnSpeaker.circleClip()
        self.btnSpeaker.backgroundColor = Constants.Color.bgrItem
        self.btnWiki.setImage(Constants.Image.wikiSystem, for: .normal)
        self.btnWiki.circleClip()
        self.btnWiki.backgroundColor = Constants.Color.bgrItem
        self.btnHeart.setBackgroundImage(Constants.Image.heartFillSystem, for: .normal)
        self.vTagName.backgroundColor = Constants.Color.bgrItem
        self.vTagName.addConnerRadius(radius: 20)
    }
    
    override func setUpTap() {
        btnBack.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnBack.dimButton()
                self?.pop()
            })
            .disposed(by: disposeBag)
        
        btnPrevious.defaultTap()
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                self.btnPrevious.dimButton()
                self.viewModel.currentIndex -= 1
                self.scrollToIndex(index: self.viewModel.currentIndex, isAnimate: true)
            })
            .disposed(by: disposeBag)
        
        btnNext.defaultTap()
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                self.btnNext.dimButton()
                self.viewModel.currentIndex += 1
                self.scrollToIndex(index: self.viewModel.currentIndex, isAnimate: true)
            })
            .disposed(by: disposeBag)
        
        btnSpeaker.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnSpeaker.dimButton()
                self?.speakText()
            })
            .disposed(by: disposeBag)
        
        btnWiki.defaultTap()
            .subscribe(onNext: { [weak self] in
                self?.btnWiki.dimButton()
                self?.openWiki()
            })
            .disposed(by: disposeBag)
        
        btnHeart.defaultTap()
            .subscribe(onNext: { [weak self] _ in
                self?.btnHeart.dimButton()
                self?.btnHeartToggle()
            }).disposed(by: disposeBag)
    }

    override func bindViewModel() {
        self.viewModel.getListTag()
            .subscribe(onNext: { [weak self] value in
                guard let self = self else {
                    return
                }
                self.viewModel.listTags.accept(self.viewModel.preHandle(array: value))
            })
            .disposed(by: disposeBag)
        
        self.viewModel.listTags
            .subscribe(onNext: { [weak self] value in
                if value.count > 0 {
                    DispatchQueue.main.async {
                        self?.cltvListTags.reloadData()
                        let indexPath = IndexPath(item: 2, section: 0)
                        self?.cltvListTags.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                        self?.updateUIWithIndex(index: 2)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        self.viewModel.title.bind(to: self.lbTitle.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    func scrollToIndex(index: Int, isAnimate: Bool) {
        let indexPath = IndexPath(item: index, section: 0)
        self.cltvListTags.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: isAnimate)
    }

    func updateUIWithIndex(index: Int) {
        let item = self.viewModel.listTags.value[index]
        self.lbTagName.text = item.tagName
        self.updateUIBtnHeart(isFavorite: item.isFavorite ?? false)
    }
    
    func updateUIBtnHeart(isFavorite: Bool) {
        let heart = isFavorite ? Constants.Image.heartFillSystem : Constants.Image.heartSystem
        self.btnHeart.setBackgroundImage(heart, for: .normal)
    }
    
    func openWiki() {
        guard let tagName = self.viewModel.listTags.value[self.viewModel.currentIndex].tagName else {
            return
        }
        let wikiVC = WikiWebViewViewController(title: tagName)
        let navWeb = UINavigationController(rootViewController: wikiVC)
        self.present(navWeb, animated: true, completion: nil)
    }
    
    func btnHeartToggle() {
        guard let isFavoite = self.viewModel.listTags.value[self.viewModel.currentIndex].isFavorite else {
            return
        }
        
        self.updateUIBtnHeart(isFavorite: !isFavoite)
        self.viewModel.updateStatusFavorite(isFavorite: !isFavoite)
    }
    
    // Function to speak the entered text
    func speakText() {
        guard let tagName = self.viewModel.listTags.value[self.viewModel.currentIndex].tagName else {
            return
        }
        // Create an AVSpeechUtterance with the provided text
        let utterance = AVSpeechUtterance(string: tagName)
        
        // Select a voice for speech synthesis (optional)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        // Speak the text using the speech synthesizer
        synthesizer.speak(utterance)
    }
}

extension TagsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.listTags.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.nibNameClass, for: indexPath) as! TagCollectionViewCell
        cell.configure(item: self.viewModel.listTags.value[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cltvListTags.frame.width * 2 / 3, height: self.cltvListTags.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.viewModel.initialContentOffset = scrollView.contentOffset
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.x > self.viewModel.initialContentOffset.x {
            self.viewModel.currentIndex += 1
        } else if scrollView.contentOffset.x < self.viewModel.initialContentOffset.x {
            self.viewModel.currentIndex -= 1
        }
        scrollToIndex(index: self.viewModel.currentIndex, isAnimate: true)
        targetContentOffset.pointee = scrollView.contentOffset
        updateUIWithIndex(index: self.viewModel.currentIndex)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if self.viewModel.currentIndex == 1 {
            self.viewModel.currentIndex = self.viewModel.listTags.value.count - 3
            scrollToIndex(index: self.viewModel.currentIndex, isAnimate: false)
        } else if self.viewModel.currentIndex == self.viewModel.listTags.value.count - 2 {
            self.viewModel.currentIndex = 2
            scrollToIndex(index: self.viewModel.currentIndex, isAnimate: false)
        }
        updateUIWithIndex(index: self.viewModel.currentIndex)
    }
}
