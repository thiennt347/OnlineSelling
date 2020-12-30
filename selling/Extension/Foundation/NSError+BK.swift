///
/// Project: BKCore
/// File: NSError+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit

extension NSError {
    public static func errorWithMessage(code: Int, msg: String) -> NSError {
        var userInfo = [String: AnyObject]()
        userInfo[NSLocalizedDescriptionKey] = msg as AnyObject?
        userInfo[NSLocalizedFailureReasonErrorKey] = msg as AnyObject?
        let error = NSError(domain: "Error", code: code, userInfo: userInfo)
        return error
    }
}
