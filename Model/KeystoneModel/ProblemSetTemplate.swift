//
//  ProblemSetTemplate.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/25/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData


extension ProblemSetTemplate {
    
    @NSManaged public private(set) var name:        String
    @NSManaged public private(set) var defaults:    [Constituent]?
    @NSManaged public private(set) var header:      [Constituent]?
    @NSManaged public private(set) var footer:      [Constituent]?
    @NSManaged public private(set) var problemSets: Set<ProblemSet>
    
}


extension ProblemSetTemplate {
    
    public func newProblemSet() -> ProblemSet {
        return ProblemSet.insertIntoContext(managedObjectContext!, withTemplate: self)
    }
    
}


extension ProblemSetTemplate {

    public static func insertIntoContext(moc: NSManagedObjectContext, name: String) -> ProblemSetTemplate {
        
        let problemSetTemplate: ProblemSetTemplate = moc.insertObject()
        problemSetTemplate.name         = name
        problemSetTemplate.problemSets  = []
        
        return problemSetTemplate
        
    }

}