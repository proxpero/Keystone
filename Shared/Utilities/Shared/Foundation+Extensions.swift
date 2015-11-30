//
//  Foundation+Extensions.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

let day     = NSTimeInterval(60.0 * 60.0 * 24.0)
let week    = NSTimeInterval(day * 7.0)
let year    = week * 52.0

extension NSDate {
    
    public func randomDate(weeks weeks: Int, rangeInDays: Int) -> NSDate {

        let range = Double(rangeInDays)
        let new = week * Double(weeks)
        let result = new - (drand48() * range) + (range / 2)
        return self.dateByAddingTimeInterval(result)
    }
    
    public static func randomDate(weeksAgo weeksAgo: Int, offset: Int = 0) -> NSDate {
        return NSDate(timeIntervalSinceNow: -Double(weeksAgo) * week)
    }

    public static func randomDate(yearsAgo yearsAgo: Int, offset: Int = 0) -> NSDate {
        return NSDate(timeIntervalSinceNow: -(Double(yearsAgo) * year + Double(offset)))
    }
    
    public func since() -> String {
        let seconds = abs(NSDate().timeIntervalSince1970 - self.timeIntervalSince1970)
        if seconds <= 120 {
            return "just now"
        }
        let minutes = Int(floor(seconds / 60))
        if minutes <= 60 {
            return "\(minutes) mins ago"
        }
        let hours = minutes / 60
        if hours <= 24 {
            return "\(hours) hrs ago"
        }
        if hours <= 48 {
            return "yesterday"
        }
        let days = hours / 24
        if days <= 30 {
            return "\(days) days ago"
        }
        if days <= 14 {
            return "last week"
        }
        let months = days / 30
        if months == 1 {
            return "last month"
        }
        if months <= 12 {
            return "\(months) months ago"
        }
        let years = months / 12
        if years == 1 {
            return "last year"
        }
        return "\(years) years ago"
    }
}