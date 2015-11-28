//
//  ConstituentStyle.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/27/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public final class ConstituentStyle: ManagedObject { }

extension ConstituentStyle {
    
    @NSManaged public private(set) var name:        String
    @NSManaged public private(set) var identifier:  String
    @NSManaged public private(set) var inset:       Float
    @NSManaged public private(set) var rawMarker:   Int16
    @NSManaged public private(set) var fontSize:    Float
    @NSManaged public private(set) var fontName:    String

}

extension ConstituentStyle: ManagedObjectType {
    
    public static var entityName: String { return "ConstituentStyle" }
    public static var defaultSortDescriptors: [NSSortDescriptor] { return [] }
    public static var defaultPredicate: NSPredicate { return NSPredicate() }
    
}

extension ConstituentStyle {
    static func defaultConstituentStyleInContext(context: NSManagedObjectContext) -> ConstituentStyle {
        
        return findOrCreateInContext(context,
            matchingPredicate: NSPredicate(format: "identifier = 'DefaultStyle'")) { style in
                style.name          = "Default"
                style.identifier    = "DefaultStyle"
                style.inset         = 0.0
                style.rawMarker     = 0
                style.fontSize      = 12.0
                style.fontName      = "HelveticaNeue"
        }
    }
}