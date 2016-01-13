//
//  ConstituentStyle.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/27/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

private enum CodingKeyIdentifier: String {
    case Name           = "ConstituentStyleName"
    case Identifier     = "ConstituentStyleIdentifier"
    case Inset          = "ConstituentStyleInset"
    case RawMarker      = "ConstituentStyleRawMarker"
    case FontSize       = "ConstituentStyleFontSize"
    case FontName       = "ConstituentStyleFontName"
    case StylesDict     = "ConstituentStyleDictionary"
    case DefaultKey     = "DefaultConstituentStyleKey"
}

public class ConstituentStyle: NSObject, NSSecureCoding {
    
    public var name:        String
    public var identifier:  String
    public var inset:       Float
    public var rawMarker:   Int
    public var fontSize:    Float
    public var fontName:    String

    init(
        name: String,
        identifier: String,
        inset: Float,
        rawMarker: Int,
        fontSize: Float,
        fontName: String)
    {
        
        self.name = name
        self.identifier = identifier
        self.inset = inset
        self.rawMarker = rawMarker
        self.fontSize = fontSize
        self.fontName = fontName
        
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(name,       forKey: CodingKeyIdentifier.Name.rawValue)
        aCoder.encodeObject(identifier, forKey: CodingKeyIdentifier.Identifier.rawValue)
        aCoder.encodeFloat(inset,       forKey: CodingKeyIdentifier.Inset.rawValue)
        aCoder.encodeInteger(rawMarker, forKey: CodingKeyIdentifier.RawMarker.rawValue)
        aCoder.encodeFloat(fontSize,    forKey: CodingKeyIdentifier.FontSize.rawValue)
        aCoder.encodeObject(fontName,   forKey: CodingKeyIdentifier.FontName.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {

        guard let
            name        = aDecoder.decodeObjectForKey(CodingKeyIdentifier.Name.rawValue) as? String,
            identifier  = aDecoder.decodeObjectForKey(CodingKeyIdentifier.Identifier.rawValue) as? String,
            fontName    = aDecoder.decodeObjectForKey(CodingKeyIdentifier.FontName.rawValue) as? String
        else {
            return nil
        }

        let inset       = aDecoder.decodeFloatForKey(CodingKeyIdentifier.Inset.rawValue)
        let rawMarker   = aDecoder.decodeIntegerForKey(CodingKeyIdentifier.RawMarker.rawValue)
        let fontSize    = aDecoder.decodeFloatForKey(CodingKeyIdentifier.FontSize.rawValue)

        
        self.init(
            name:   name,
            identifier: identifier,
            inset: inset,
            rawMarker: rawMarker,
            fontSize: fontSize,
            fontName: fontName
        )
    }
    
    public static func supportsSecureCoding() -> Bool { return true }
}

extension ConstituentStyle {
    
    static func defaultConstituentStyle() -> ConstituentStyle {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        var stylesDict = userDefaults.dictionaryForKey(CodingKeyIdentifier.StylesDict.rawValue) ?? Dictionary<String, AnyObject>()
        
        if let defaultStyle = stylesDict[CodingKeyIdentifier.DefaultKey.rawValue] as? ConstituentStyle {
            return defaultStyle
        }
        
        let defaultStyle = ConstituentStyle(
            name:       "Default",
            identifier: "DefaultStyle",
            inset:      0.0,
            rawMarker:  0,
            fontSize:   15.0,
            fontName:   "HelveticaNeue"
        )
        
        stylesDict[CodingKeyIdentifier.DefaultKey.rawValue] = defaultStyle
        userDefaults.setObject(stylesDict, forKey: CodingKeyIdentifier.StylesDict.rawValue)
        
        return defaultStyle
        
    }
}