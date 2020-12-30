///
/// Project: BKCore
/// File: StringExtension+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit

private let EMPTY_STRING = ""
extension String {
    public var floatValue: Float {
        return Float(self) ?? 0
    }
    
    public var intValue: Int {
        return Int(self) ?? 0
    }
    
    public var doubleValue: Double {
        return Double(self) ?? 0
    }
    
    public static var empty: String {
        return EMPTY_STRING
    }
    
    public static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    public var length: Int {
        return self.count
    }
    
    public func encodeURL() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    public func isValidEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    public func isValidPhone() -> Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    public func isValidPassword() -> Bool {
        let pass = ".{6,}"
        return NSPredicate(format: "SELF MATCHES %@", pass).evaluate(with: self)
    }
    
    public func isNumber() -> Bool {
        let numberRegEx = ".*[0-9]+.*"
        let texttest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        let numberresult = texttest.evaluate(with: self)
        return numberresult
    }
    
    public func hasSpecialCharacter() -> Bool {
        let specialCharacterRegEx = ".*[!&^%$#@()/]+.*"
        let texttest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        let specialresult = texttest.evaluate(with: self)
        return specialresult
    }
}

extension String {
    public func encodeToBase64String() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        
        return nil
    }
    
    public func decodeBase64String() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
}

extension String {
    public static func formatGrouping(value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value))!
    }
}

extension String {
    public func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    public func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    public func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[self.startIndex..<toIndex])
    }
    
    public func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    /// Return a string with first letter was capitaled
    public var capitalizedFirstLetter: String {
        var retVal = String.empty
        if self.length < 2 {
            retVal = self.capitalized
        } else {
            retVal = "\(self.substring(to: 1).capitalized)\(self.substring(from: 1))"
        }
        return retVal
    }
    
    /// Return string were converted from HTML
    public func stringFromHTML(string: String?) -> String {
        do {
            let str = try NSAttributedString(data: string!.data(using: String.Encoding.utf8, allowLossyConversion: true
                )!, options: [
                    NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                    NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
            return str.string
        } catch {
            print("html error\n", error)
        }
        return String.empty
    }
    
}

extension String {
    public func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    public func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: String.empty)
    }
    
    public func convertStringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)!
        return date
    }
    
    public func heightString(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    public func widthString(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
