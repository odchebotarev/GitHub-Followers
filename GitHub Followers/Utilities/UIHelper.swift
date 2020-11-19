//
//  UIHelper.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 14.11.2020.
//

import UIKit

enum UIHelper {
    
    static func createFlowLayout(in view: UIView, columnsCount: Int) -> UICollectionViewFlowLayout {
        let columnsCount = CGFloat(columnsCount)
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * (columnsCount - 1))
        let itemWidth = availableWidth / columnsCount
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
