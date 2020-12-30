///
/// Project: BKCore
/// File: UICollectionView+BK.swift
/// Created by DuyLe on 1/8/19.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit
import Spruce

extension UICollectionView {

    public func registerCellClass(cellClass: AnyClass) {
        let identifier = String.className(aClass: cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    public func registerCellNib(cellClass: AnyClass) {
        let identifier = String.className(aClass: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    public func dequeue<T: UICollectionViewCell>(aClass: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: aClass.className, for: indexPath) as! T
    }
    
    public func reloadDataWithAnimation() {
        reloadData()
        runOnMainThreadAfterDelay(delay: 0.1) {
            self.spruce.animate(BKConfiguration.instance.collectionViewAnimations, duration: 1)
        }
    }
}
