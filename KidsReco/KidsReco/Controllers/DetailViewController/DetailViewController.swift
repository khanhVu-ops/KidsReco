//
//  DetailViewController.swift
//  KidsReco
//
//  Created by mr.root on 7/20/23.
//

import UIKit
import RxSwift
import RxGesture

class DetailViewController: BaseViewController {
    
    lazy var backButton: UIButton = {
       let button = UIButton()
        button.setImage(Constants.Image.backButtonSystem.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    @IBOutlet weak var headerView: CustomNavigationHeaderView!
    @IBOutlet weak var collectionView: InfinityCollectionView!
    @IBOutlet weak var nameAnimalLable: UILabel!
    @IBOutlet weak var moveLeftImage: UIImageView!
    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var descriptionImage: UIImageView!
    @IBOutlet weak var moveRightImage: UIImageView!
    
    @IBOutlet weak var viewMoveLeft: UIView!
    @IBOutlet weak var viewMoveRight: UIView!
    @IBOutlet weak var viewSpeaker: UIView!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var viewCircle: UIView!
    @IBOutlet weak var viewNameLable: UIView!
    
    private var viewModel: DetailViewModel = DetailViewModel()
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0
    
    private var isScrollItem: Bool = true
    private var index = 0
    private var totalIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
        setupViewModel()
        viewModel.getItem()
    }
    
    override func setUpUI() {
        
        viewNameLable.setCornerRadius(cornerRadius: 15)
        viewNameLable.backgroundColor = Constants.Color.bgrItem
    
        viewCircle.circleClip()
        viewCircle.addBorder(borderWidth: 1, borderColor: .black)
        
        viewDescription.circleClip()
        viewDescription.addBorder(borderWidth: 1, borderColor: .black)
        
        viewSpeaker.circleClip()
        viewSpeaker.addBorder(borderWidth: 1, borderColor: .black)
        
        headerView.customConfig(leftButtons: [backButton], rightButtons: [])
        headerView.titleValue = "Animal"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.numberOfSets = 3
    }
    
    private func setupViewModel() {
        viewModel.animalNameBehaviorSubject.subscribe(onNext: { [weak self] text in
            guard let `self` = self else {return}
            self.nameAnimalLable.text = text ?? ""
        }).disposed(by: disposeBag)
    }
    
    override func setUpTap() {
        backButton
            .defaultTap()
            .withUnretained(self)
            .subscribe(onNext: { _ in
            self.pop()
        }).disposed(by: disposeBag)
        
        moveLeftImage.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { _ in
                self.scrollitem(isShow: false)
            }).disposed(by: disposeBag)
        
        speakerImage.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        
        descriptionImage.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        
        moveRightImage.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { _ in
                self.scrollitem(isShow: true)
            }).disposed(by: disposeBag)
    }
    
    func scrollitem(isShow: Bool) {
        if viewModel.animalArrays.count >= totalIndex + 1 {
            if isShow {
                if index < viewModel.animalArrays.count {
                    print("vuongdv index \(index)")
                    self.currentPage = index
                    index += 1
                }
            } else {
                if index >= 1 {
                    index -= 1
                    self.currentPage = index
                }
            }
            
        print("vuongdv currentPage \(currentPage)")
            DispatchQueue.main.async {[weak self] in
                guard let `self` = self else {return}
                self.viewModel.getItem(with: self.currentPage)
                self.collectionView.scrollToItem(at: IndexPath(row: self.currentPage, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.animalArrays.count * (self.collectionView.numberOfSets ?? 1)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let index = indexPath.row % viewModel.animalArrays.count
       
        if  viewModel.animalArrays.count >= index + 1 {
            let item = viewModel.animalArrays[index]
            self.index = index
            cell.bindData(with: item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = (collectionViewWidth / 1.5)
        let cellHeight = collectionView.bounds.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
        {
//            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
//            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//
//            if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
//                let middleIndexPath = IndexPath(item: 1000 * 500, section: 0) // Choose a suitable multiplier
//                if indexPath.item == 0 || indexPath.item == collectionView.numberOfItems(inSection: 0) - 1 {
//                    collectionView.scrollToItem(at: middleIndexPath, at: .centeredHorizontally, animated: false)
//                }
//            }
            
//            let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//            var offset = targetContentOffset.pointee
//            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//            let roundedIndex = round(index)
//            print("vuongdv \(roundedIndex)")
//
//            let visibleWidth = scrollView.bounds.size.width
//              - scrollView.contentInset.left
//              - scrollView.contentInset.right
//            offset = CGPoint(
//              x: roundedIndex * cellWidthIncludingSpacing
//                - scrollView.contentInset.left
//                + layout.itemSize.width / 2
//                - visibleWidth / 2,
//              y: -scrollView.contentInset.top
//            )
////            print("vuongdv \(offset.x)")
//            targetContentOffset.pointee = offset
//            offset = CGPoint(
//              x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left + cellWidthIncludingSpacing / 2 - visibleWidth,
//              y: -scrollView.contentInset.top
//            )
            
        }
}
