///
/// Project: BKCore
/// File: UIImage+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit
import CoreGraphics

extension UIImage {
    public static func create(size aSize: CGSize, solidColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: aSize.width, height: aSize.height)
        UIGraphicsBeginImageContextWithOptions(aSize, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    public static func create(size aSize: CGSize, solidColor color: UIColor, cornerRadius: CGFloat) -> UIImage {
        let path = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: aSize), cornerRadius: cornerRadius)
        
        UIGraphicsBeginImageContextWithOptions(aSize, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        path.fill()
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    public func imageWith(scaledToWidth: CGFloat, padding: CGFloat = 2) -> UIImage {
        let oldWidth = self.size.width
        let scaleFactor = scaledToWidth / oldWidth
        
        let newHeight = self.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        return self.imageWith(scaledToSize: CGSize(width: newWidth, height: newHeight), padding: padding)
    }
    
    public func createImageWithTintColor(color: UIColor) -> UIImage {
        let size = self.size
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        self.draw(at: CGPoint.zero, blendMode: CGBlendMode.normal, alpha: 1.0)
        context!.setFillColor(color.cgColor)
        context!.setBlendMode(CGBlendMode.sourceIn)
        context!.setAlpha(1.0)
        let rect = CGRect(
            origin: CGPoint.zero,
            size: self.size)
        context!.fill(rect)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage!
    }
    
    public func imageWith(scaledToSize newSize: CGSize,
                          scale: CGFloat = UIScreen.main.scale,
                          padding: CGFloat = 2) -> UIImage {
        let contextSize = CGSize(width: newSize.width + 2 * padding, height: newSize.height + 2 * padding)
        UIGraphicsBeginImageContextWithOptions(contextSize, false, scale)
        self.draw(in: CGRect(origin: CGPoint(x: padding, y: padding), size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func cropToSquare() -> UIImage {
        // Create a copy of the image without the imageOrientation property so it is in its native orientation (landscape)
        let contextImage: UIImage = UIImage(cgImage: self.cgImage!)
        
        // Get the size of the contextImage
        let contextSize: CGSize = contextImage.size
        
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        // Check to see which length is the longest and create the offset based on that length, then set the width and height of our rect
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            width = contextSize.height
            height = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            width = contextSize.width
            height = contextSize.width
        }
        
        let rect = CGRect(x: posX, y: posY, width: width, height: height)
        
        // Create bitmap image from context using the rect
        let imageRef = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return image
    }
    
    public static func imageFromView(v: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(v.bounds.size, false, UIScreen.main.scale)
        v.drawHierarchy(in: v.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

private let kIconFontName = "untitled-font-1"
extension UIImage {
    public static func iconWith(txt: String, textSize: CGFloat, color: UIColor) -> UIImage {
        let kPadding: CGFloat = 4
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: textSize + kPadding, height: textSize + kPadding))
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.frame = frame
        
        let label = UILabel(frame: frame)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = color
        label.text = txt
        label.font = UIFont(name: kIconFontName, size: textSize)!
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, UIScreen.main.scale)
        
        let ctx = UIGraphicsGetCurrentContext()!
        imageView.layer.render(in: ctx)
        label.layer.render(in: ctx)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithText!
    }
}
