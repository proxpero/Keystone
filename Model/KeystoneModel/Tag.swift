//
//  Tag.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public final class Tag: ManagedObject { }

extension Tag {
    
    @NSManaged public private(set) var name: String?
    @NSManaged public private(set) var note: String?
    @NSManaged public private(set) var items: NSSet?
    
}
