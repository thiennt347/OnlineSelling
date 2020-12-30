///
/// Project: BKCore
/// File: DateExtension+BK.swift
/// Created by DuyLe on 6/14/18.
/// Copyright © 2018-2019 Beeknights Co., Ltd. All rights reserved.
///

import UIKit

extension Date {
    public func isBetweeen(date date1: Date, andDate date2: Date) -> Bool {
        return date1.compare(self as Date).rawValue * self.compare(date2 as Date).rawValue >= 0
    }

    public static func ISOStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        return dateFormatter.string(from: date as Date).appending("Z")
    }

    public static func dateFromISOString(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return dateFormatter.date(from: string)!
    }

    public func dateToString(format: String, locale: Locale = Locale.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    public static func dateFromString(format: String, dateString: String, locale: Locale = Locale.current) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)!
    }

    public func isInvalidDateAndMonth() -> Bool {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.year, .month]
        let components = calendar.dateComponents(unitFlags, from: self)
        return (components.month! == 1 && components.year! == 1970)
    }

    public func timeAgo() -> String {
        let duration = Int(abs(self.timeIntervalSinceNow) / 60)
        if duration < 60 {
            return "\(duration) minutes ago"
        }

        if duration < 120 {
            return "1 hour ago"
        }

        if duration < 60 * 24 {
            return "\(duration / 60) hours ago"
        }

        if duration < 2 * 60 * 24 {
            return "Yesterday"
        }

        return "\(duration / (60 * 24)) days ago"
    }

    public var startOfWeek: Date {
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date)
        return date.addingTimeInterval(dslTimeOffset)
    }

    public var endOfWeek: Date {
        return Calendar.current.date(byAdding: .second, value: 604799, to: self.startOfWeek)!
    }

    public var startOfDate: Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }

    public var endOfDate: Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }

    public var dayOfWeek: Int {
        //from 1 thru 7
        let weekDay = Calendar.current.dateComponents([.weekday], from: self).weekday!
        return weekDay - 1
    }

    public func compareIgnoreTime(dateToCompare date: Date) -> ComparisonResult {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.compare(self, to: date, toGranularity: .day)
    }

    public func daysBefore(_ compare: Date) -> Int {
        let calendar = NSCalendar.current

        // Replace the hour (time) of both dates with 00:00
        let date = calendar.startOfDay(for: self)
        let today = calendar.startOfDay(for: compare)

        let components = calendar.dateComponents([.day], from: date, to: today)
        return components.day ?? 0
    }

    public func isBefore(_ compare: Date) -> Bool {
        return daysBefore(compare) > 0
    }

    public func isBeforeOrSame(_ compare: Date) -> Bool {
        return daysBefore(compare) >= 0
    }

    public func isAfter(_ compare: Date) -> Bool {
        return daysBefore(compare) < 0
    }

    public func isAfterOrSame(_ compare: Date) -> Bool {
        return daysBefore(compare) <= 0
    }
}

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601 = ISO8601DateFormatter([.withFullDate,
                                               .withTime,
                                               .withDashSeparatorInDate,
                                               .withColonSeparatorInTime])
    static let formatDefault = ISO8601DateFormatter([.withFullDate])
}

extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension String {
    var iso8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
}
