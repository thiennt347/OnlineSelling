///
/// Project: BKCore
/// File: UINavigationBar+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit

extension UINavigationBar {
    public func setNavigationBarTintColor(color: UIColor!, andAlpha alpha: CGFloat = 1) {
        var targetAlpha = alpha
        if targetAlpha > 1 {
            targetAlpha = 1
        }

        if targetAlpha < 0 {
            targetAlpha = 0
        }

        self.isTranslucent = targetAlpha < 1

        let backgroundImage = UIImage.create(size: CGSize(width: self.bounds.width, height: self.bounds.height + 20), solidColor: color.withAlphaComponent(targetAlpha))
        self.setBackgroundImage(backgroundImage, for: .default)
    }

    public func hideBottomHairline() {
        if let navigationBarImageView = hairlineImageViewInNavigationBar(view: self) {
            navigationBarImageView.isHidden = true
        }
    }

    public func showBottomHairline() {
        if let navigationBarImageView = hairlineImageViewInNavigationBar(view: self) {
            navigationBarImageView.isHidden = false
        }
    }

    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as? UIImageView)
        }

        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView = hairlineImageViewInNavigationBar(view: subview) {
                return imageView
            }
        }

        return nil
    }

    public func setupDefaultNavigationBar(barTintColor: UIColor = .white, tintColor: UIColor = .red, titleColor: UIColor = .black, titleFont: UIFont = UIFont.boldSystemFont(ofSize: 16), isHideButtonLine: Bool = true) {
        self.barTintColor = barTintColor
        // buttons color
        self.tintColor = tintColor
        self.isOpaque = false
        self.isTranslucent = false
        self.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: titleColor,
            NSAttributedString.Key.font: titleFont,
        ]

        if isHideButtonLine == true {
            self.hideBottomHairline()
        } else {
            self.showBottomHairline()
        }
    }
}
