//
//  InfinityCollectionView.swift
//  KidsReco
//
//  Created by mr.root on 7/22/23.
//

import Foundation
import UIKit

class InfinityCollectionView: UICollectionView {
    var numberOfSets: Int?
    
    override func layoutSubviews() {
           super.layoutSubviews()
           let centerOffsetX = self.contentSize.width / 2.0
           let distanceX = abs(self.contentOffset.x - centerOffsetX) // convert absolute value
           if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
               let oneSetWidth = (self.contentSize.width + flowLayout.minimumLineSpacing) / CGFloat(numberOfSets ?? 0)
               if (distanceX > oneSetWidth) {
                   // When one set has been scrolled, it returns to original position
                   // fmodf = num1 - integerValue * num2
                   let offset = fmodf(Float(self.contentOffset.x - centerOffsetX), Float(oneSetWidth))
                   self.contentOffset = CGPoint(x: centerOffsetX + CGFloat(offset), y: self.contentOffset.y)
               }
           }
           self.layoutIfNeeded()
       }
}
