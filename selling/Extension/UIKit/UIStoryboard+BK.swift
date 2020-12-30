///
/// Project: BKCore
/// File: UIStoryboard+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit

extension UIStoryboard {
    public func initializeController<T: UIViewController>(withClass: T.Type) -> T {
        return self.instantiateViewController(withIdentifier: withClass.className) as! T
    }
}
