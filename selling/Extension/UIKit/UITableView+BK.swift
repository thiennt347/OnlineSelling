///
/// Project: BKCore
/// File: UITableView+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit
import Spruce

extension UITableView {
    public func registerCellNib(cellClass: AnyClass) {
        let identifier = String.className(aClass: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    public func registerHeaderFooterViewClass(viewClass: AnyClass) {
        let identifier = String.className(aClass: viewClass)
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    public func registerHeaderFooterViewNib(viewClass: AnyClass) {
        let identifier = String.className(aClass: viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    public func dequeue<T: UITableViewCell>(aClass: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: aClass.className) as! T
    }
    
    public func dequeue<T: UITableViewHeaderFooterView>(aClass: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: aClass.className) as! T
    }
    
    public func reloadDataWithAnimation() {
        reloadData()
        runOnMainThreadAfterDelay(delay: 0.1) {
            self.spruce.animate(BKConfiguration.instance.tableViewAnimations, duration: 0.4)
        }
    }
}
