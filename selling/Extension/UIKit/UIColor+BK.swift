///
/// Project: BKCore
/// File: UIColor+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit

extension UIColor {
    public convenience init(hex: String, alpha: CGFloat = 1) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    public static func colorWithHex(hexString: String, alpha: CGFloat = 1) -> UIColor {
        var hexWithoutSymbol = hexString
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol.remove(at: hexWithoutSymbol.startIndex)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt: UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r: Double!, g: Double!, b: Double!
        switch hexWithoutSymbol.count {
        case 3: // #RGB
            r = Double(((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f))
            g = Double(((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f))
            b = Double(((hexInt << 4) & 0xf0 | hexInt & 0x0f))
            break
        case 6: // #RRGGBB
            r = Double((hexInt >> 16) & 0xff)
            g = Double((hexInt >> 8) & 0xff)
            b = Double(hexInt & 0xff)
            break
        default:
            break
        }
        
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: alpha)
    }
    
    public static func colorWith(r: Int, g: Int, b: Int, alpha: Float = 1) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
}
