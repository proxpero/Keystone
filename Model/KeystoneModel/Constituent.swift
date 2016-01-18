//
//  Constituent.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/25/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public typealias ConstituentItem = NSAttributedString

private enum CodingKeyIdentifier: String {
    case Style = "StyleIdentifier"
    case Items = "ConstituentItems"
}

public final class Constituent: NSObject, NSSecureCoding {
    
    public var style: ConstituentStyle
    public private(set) var constituentItems: [ConstituentItem]
    
    init(
        styleIdentifier:    String,
        constituentItems:   [NSAttributedString]     = [])
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let style = userDefaults.objectForKey(styleIdentifier) as? ConstituentStyle {
            self.style = style
        } else {
            self.style = ConstituentStyle.defaultConstituentStyle()
        }
        
        self.constituentItems     = constituentItems
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(style.identifier, forKey: CodingKeyIdentifier.Style.rawValue)
        aCoder.encodeObject(constituentItems, forKey: CodingKeyIdentifier.Items.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard let
            styleIdentifier   = aDecoder.decodeObjectForKey(CodingKeyIdentifier.Style.rawValue) as? String,
            attributedStrings = aDecoder.decodeObjectForKey(CodingKeyIdentifier.Items.rawValue) as? [NSAttributedString]
        else { return nil }
        
        self.init(
            styleIdentifier:    styleIdentifier,
            constituentItems:   attributedStrings
        )
    }
    
    public static func supportsSecureCoding() -> Bool { return true }
}


extension Constituent {
    
    public func addConstituentItem(text: ConstituentItem) {
        constituentItems.append(text)
    }
    
    public func insertConstituentItem(text: ConstituentItem, var atIndex index: Int) {
        if index <= 0 { index = 0 }
        if index > constituentItems.count { index = constituentItems.count }
        constituentItems.insert(text, atIndex: index)
    }
    
    public func removeConstituentItemAtIndex(index: Int) -> ConstituentItem? {
        guard index >= 0 && index < constituentItems.count else { return nil }
        let constituentItem = constituentItems[index]
        constituentItems.removeAtIndex(index)
        return constituentItem
    }
}



enum Marker: Int {
    case None
    case NumberWithDot
    case NumberOpenCloseParens
    case NumberCloseParens
    case RomanUpperDot
    case RomanUpperOpenCloseParens
    case RomanUpperCloseParens
    case RomanLowerDot
    case RomanLowerOpenCloseParens
    case RomanLowerCloseParens
    case AlphaUpperDot
    case AlphaUpperOpenCloseParens
    case AlphaUpperCloseParens
    case AlphaLowerDot
    case AlphaLowerOpenCloseParens
    case AlphaLowerCloseParens
    
    static let romanNumerals = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI"]
    
    func romanNumeral(decimal: Int) -> String {
        guard decimal < 26 else { return "" }
        return Marker.romanNumerals[decimal]
    }
    
    static let alphabet = ("A"..."Z" as Range).map { String($0) }
    func letter(decimal: Int) -> String {
        guard decimal < 26 else { return "" }
        return Marker.alphabet[decimal]
    }
    
    static let markerLabels = ["None", "1. 2. 3. 4.", "(1) (2) (3) (4)", "1) 2) 3) 4)", "I. II. III. IV.", "(I) (II) (III) (IV)", "I) II) III) IV)", "i. ii. iii. iv.", "(i) (ii) (iii) (iv)", "i) ii) iii) iv)", "A. B. C. D.", "(A) (B) (C) (D)", "A) B) C) D)", "a. b. c. d.", "(a) (b) (c) (d)", "a) b) c) d)"]
    
    func textAtIndex(index: Int) -> String {
        switch self {
        case .None: return ""
        case .NumberWithDot: return "\(index+1)."
        case .NumberOpenCloseParens: return "(\(index+1))"
        case .NumberCloseParens: return "\(index+1))"
        case .RomanUpperDot: return "\(romanNumeral(index).uppercaseString)"
        case .RomanUpperOpenCloseParens: return "(\(romanNumeral(index).uppercaseString))"
        case .RomanUpperCloseParens: return "\(romanNumeral(index).uppercaseString))"
        case .RomanLowerDot: return "\(romanNumeral(index).lowercaseString)"
        case .RomanLowerOpenCloseParens: return "(\(romanNumeral(index).lowercaseString))"
        case .RomanLowerCloseParens: return "\(romanNumeral(index).lowercaseString))"
        case .AlphaUpperDot: return "\(letter(index).uppercaseString)."
        case .AlphaUpperOpenCloseParens: return "(\(letter(index).uppercaseString))"
        case .AlphaUpperCloseParens: return "\(letter(index).uppercaseString))"
        case .AlphaLowerDot: return "\(letter(index).lowercaseString)."
        case .AlphaLowerOpenCloseParens: return "(\(letter(index).lowercaseString))"
        case .AlphaLowerCloseParens: return "\(letter(index).lowercaseString))"
        }
    }
    
    func markerLabel() -> String {
        guard self.rawValue < Marker.markerLabels.count else { return "" }
        return Marker.markerLabels[self.rawValue]
    }
}

extension UnicodeScalar: ForwardIndexType {
    public func successor() -> UnicodeScalar {
        return UnicodeScalar(value + 1)
    }
}
