//
//  Configtion.swift
//  selling
//
//  Created by Thien on 12/30/20.
//

import Foundation
import UIKit
import Spruce

public typealias AppLanguage = (name: String, code: String)

@objc public class BKConfiguration: NSObject {
    private static var _instance = BKConfiguration()
    public static var instance: BKConfiguration {
        return _instance
    }
    
    public override init() { }
    public static func updateConfiguration(config: BKConfiguration) {
        self._instance = config
    }
    
    // MARK: UIs
    public var appName = "Enter App Name"
    public var alertOkBtn = "OK"
    public var alertCancelBtn = "Cancel"
    public var alertAddBtn = "Add"

    // MARK: APIs
    public var maximumRetryTimes: Int = 3
    public var generalResultLimit: UInt = 20
    public var itemsPerPage: Int = 30

    // MARK: Language
    public let english: AppLanguage = ("English", "en")
    public let vietnamese: AppLanguage = ("Tiếng Việt", "vi")
    
    // MARK: Animation
    public let tableViewAnimations: [StockAnimation] = [.slide(.left, .severely), .fadeIn]
    public let collectionViewAnimations: [StockAnimation] = [.slide(.up, .moderately), .fadeIn]
}

