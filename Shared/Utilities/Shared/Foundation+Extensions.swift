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

extension NSAttributedString {
    
    func sizeForWidth(width: CGFloat, height: CGFloat) -> NSSize {
        
        if self.string.characters.count == 0 { return NSZeroSize }
        
        let size = NSMakeSize(width, height)
        let textContainer = NSTextContainer(containerSize: size)
        let textStorage = NSTextStorage(attributedString: self)
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        layoutManager.hyphenationFactor = 0.0
        layoutManager.glyphRangeForTextContainer(textContainer)
        
        var result = layoutManager.usedRectForTextContainer(textContainer).size
        let extraLineSize = layoutManager.extraLineFragmentRect.size
        if extraLineSize.height > 0 {
            result.height -= extraLineSize.height
        }
        return result
    }
    
    func heightForWidth(width: CGFloat) -> CGFloat {
        return sizeForWidth(width, height: CGFloat.max).height
    }
    
    func widthForHeight(height: CGFloat) -> CGFloat {
        return sizeForWidth(CGFloat.max, height: height).width
    }
}

extension String {
    func sizeForWidth(width: CGFloat, height: CGFloat, attributes: [String:AnyObject]) -> NSSize {
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        return attributedString.sizeForWidth(width, height: height)
    }
    
    func heightForWidth(width: CGFloat, attributes: [String:AnyObject]) -> CGFloat {
        return sizeForWidth(width, height: CGFloat.max, attributes: attributes).height
    }
    
    func widthForHeight(height: CGFloat, attributes: [String:AnyObject]) -> CGFloat {
        return sizeForWidth(CGFloat.max, height: height, attributes: attributes).width
    }
    
    func sizeForWidth(width: CGFloat, height: CGFloat, font: NSFont) -> NSSize {
        let attributes = [NSFontAttributeName:font]
        return sizeForWidth(width, height: height, attributes: attributes)
    }
    
    func heightForWidth(width: CGFloat, font: NSFont) -> CGFloat {
        return sizeForWidth(width, height: CGFloat.max, font: font).height
    }
    
    func widthForHeight(height: CGFloat, font: NSFont) -> CGFloat {
        return sizeForWidth(CGFloat.max, height: height, font: font).width
    }
    
    func singleLineHeightForFont(font: NSFont) -> CGFloat {
        return "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz12345667890".heightForWidth(CGFloat.max, font: font)
    }
}

extension NSString {
    
    func sizeForWidth(width: CGFloat, height: CGFloat, attributes: [String:AnyObject]) -> NSSize {
        let attributedString = NSAttributedString(string: self as String, attributes: attributes)
        return attributedString.sizeForWidth(width, height: height)
    }
    
    func heightForWidth(width: CGFloat, attributes: [String:AnyObject]) -> CGFloat {
        return sizeForWidth(width, height: CGFloat.max, attributes: attributes).height
    }
    
    func widthForHeight(height: CGFloat, attributes: [String:AnyObject]) -> CGFloat {
        return sizeForWidth(CGFloat.max, height: height, attributes: attributes).width
    }
    
    func sizeForWidth(width: CGFloat, height: CGFloat, font: NSFont) -> NSSize {
        let attributes = [NSFontAttributeName:font]
        return sizeForWidth(width, height: height, attributes: attributes)
    }
    
    func heightForWidth(width: CGFloat, font: NSFont) -> CGFloat {
        return sizeForWidth(width, height: CGFloat.max, font: font).height
    }
    
    func widthForHeight(height: CGFloat, font: NSFont) -> CGFloat {
        return sizeForWidth(CGFloat.max, height: height, font: font).width
    }
}
