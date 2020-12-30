//
//  BKFonts.swift
//  selling
//
//  Created by Thien on 12/30/20.
//

import Foundation

@objc public class BKFontName: NSObject {
    private static var _instance = BKFontName()
    public static var instance: BKFontName {
        return _instance
    }
    
    public override init() { }
    public static func updateFontName(fonts: BKFontName) {
        self._instance = fonts
    }
    
    // MARK: Fonts
    public var regular = "SFUIText-Regular"
    public var light = "SFUIText-Light"
    public var medium = "SFUIText-Medium"
    public var semiBold = "SFUIText-Semibold"
    public var bold = "SFUIText-Bold"
    public var heavy = "SFUIText-Heavy"
    public var italic = "SFUIText-RegularItalic"
}
