//
//  BKHelpers.swift
//  selling
//
//  Created by Thien on 12/30/20.
//

import UIKit
import MBProgressHUD
import Localize_Swift

open class BKHelpers: NSObject {
    
    //MARK: - Loading indicator
    static var loadingShowingViews: [UIView] = []
    public static func showLoadingIndicator() {
        if let top = UIApplication.topViewController() {
            MBProgressHUD.showAdded(to: top.view, animated: true)
            self.loadingShowingViews.append(top.view)
        }
    }
    
    public static func hideLoadingIndicator() {
        DispatchQueue.main.async {
            for v in self.loadingShowingViews {
                MBProgressHUD.hide(for: v, animated: false)
            }
            self.loadingShowingViews.removeAll()
        }
    }
    
    //MARK: - Convert Dictionany to Json String
    public static func convertDictionanyToJsonString(dict: [String: Any]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict,
                                                      options: .prettyPrinted)
            let jsonString = String.init(data: jsonData, encoding: .ascii)!
            return jsonString
        } catch _ {
            return String.empty
        }
    }
    
    //MARK: - Convert double to currency
    public static func getCurrency(number: Double, currency: String = "đ") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:number.rounded(toPlaces: 2)))
        let result = formattedNumber! + currency
        return result
    }
    
    //MARK: - Resize Image
    public static func resizeImage(image: UIImage, targetSize: CGSize = CGSize(width: 800, height: 800)) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //MARK: - Localization
    //Note: Config language need set up initial language for the first time into AppDelegate
    //TODO: Note to document
    public static func setLanguage(code: String) {
        Localize.setCurrentLanguage(code)
    }
    
    public static func getCurrentLanguage() -> String {
        return Localize.currentLanguage()
    }
    
    public static func getCurrentLocale() -> Locale {
        return Locale(identifier: getCurrentLanguage())
    }
    
    public static func isEnglishLanguage() -> Bool {
        return self.getCurrentLanguage().compare(BKConfiguration.instance.english.code) == .orderedSame
    }
}
