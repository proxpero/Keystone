//
//  ProblemCollection.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/10/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import CoreData

public final class ProblemCollection: ManagedObject {
    
    @NSManaged public private(set) var timestamp: NSDate
    @NSManaged public private(set) var normalizedText: String
    @NSManaged public private(set) var options: Int64
    
    
}