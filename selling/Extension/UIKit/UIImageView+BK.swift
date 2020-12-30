///
/// Project: BKCore
/// File: UIImageView+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///


import Kingfisher
import UIKit

extension UIImageView {
    // This function helps to load the image from the url into the image view
    public func setImageWith(urlString: String?, placeholder: UIImage? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            image = placeholder
            return
        }
        kf.setImage(with: url)
    }

    open var imageViewSize: CGSize {
        let myImageViewWidth = bounds.size.width
        let myImageViewHeight = bounds.size.height
        let myViewWidth = UIScreen.main.bounds.width

        let ratio = myImageViewWidth.rounded() / myImageViewHeight.rounded()
        return CGSize(width: myViewWidth, height: myViewWidth * ratio)
    }
}
