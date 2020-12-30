///
/// Project: Pods
/// File: UIFont+BK.swift
/// Created by DuyLe on 6/25/19.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

@available(iOS 8.2, *)
extension UIFont {
    
    @objc public class func mySystemFont(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .light:
            return UIFont(name: BKFontName.instance.light, size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
        case .medium:
            return UIFont(name: BKFontName.instance.medium, size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
        case .semibold:
            return UIFont(name: BKFontName.instance.semiBold, size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
        case .bold:
            return UIFont(name: BKFontName.instance.bold, size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
        case .heavy:
            return UIFont(name: BKFontName.instance.heavy, size: size) ?? UIFont.systemFont(ofSize: size, weight: .heavy)
        default:
            return UIFont(name: BKFontName.instance.regular, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
    
    @objc public class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: BKFontName.instance.italic, size: size) ?? UIFont.italicSystemFont(ofSize: size)
    }
    
    @objc public convenience init?(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = BKFontName.instance.regular
//        case "CTFontThinUsage":
//            fontName = BKFontName.instance.thin
        case "CTFontLightUsage":
            fontName = BKFontName.instance.light
        case "CTFontMediumUsage":
            fontName = BKFontName.instance.medium
        case "CTFontDemiUsage":
            fontName = BKFontName.instance.semiBold
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = BKFontName.instance.bold
        case "CTFontHeavyUsage":
            fontName = BKFontName.instance.heavy
//        case "CTFontBlackUsage":
//            fontName = BKFontName.instance.black
        case "CTFontObliqueUsage":
            fontName = BKFontName.instance.italic
        default:
            fontName = BKFontName.instance.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)
    }
    
    public class func overrideInitialize() {
        guard self == UIFont.self else { return }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:weight:))),
            let myThinSystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:weight:))) {
            method_exchangeImplementations(systemFontMethod, myThinSystemFontMethod)
        }
        
        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
