///
/// Project: BKCore
/// File: UIView+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit

@IBDesignable extension UIView {

    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    var isPortrait: Bool {
        return UIDevice.current.orientation.isPortrait
    }

    var collectionViewLeftRightSpacing: CGFloat {
        if isPad {
            return isPortrait ? 54 : 12
        }
        return 0 // iPhone
    }

    var collectionViewSpacingBetweenCards: CGFloat {
        return isPad ? 10 : 1
    }

    // MARK: - IBInspectable

    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var shadow: Bool {
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
            layer.shadowOpacity = 0.2
            layer.shadowRadius = 2.0
            layer.masksToBounds = false // true would prevent CALayer shadow http://stackoverflow.com/questions/3690972/why-maskstobounds-yes-prevents-calayer-shadow
        }
        get {
            return layer.shadowOpacity > 0
        }
    }

}

extension UIView {
    public func shake(count: Float? = nil, for duration: TimeInterval? = nil, withTranslation translation: Float? = nil) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        animation.repeatCount = count ?? 2
        animation.duration = (duration ?? 0.5) / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? -5
        layer.add(animation, forKey: "shake")
    }
    
    public func shakeView() {
        shake(count: 3, for: 0.3, withTranslation: 10)
    }
    
    public func border(color: UIColor?, width: CGFloat, radius: CGFloat) {
        layer.borderColor = color?.cgColor
        layer.borderWidth = width
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        //        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
