//
//  List.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public final class List: ManagedObject { }


extension List {
    
    @NSManaged public private(set) var name: String
    @NSManaged public private(set) var header: [Constituent]
    @NSManaged public private(set) var footer: [Constituent]
    @NSManaged public private(set) var problemSets: NSOrderedSet?
    
}
