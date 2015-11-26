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
}