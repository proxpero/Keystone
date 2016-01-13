//
//  ProblemSet.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData


extension ProblemSet {
    
    @NSManaged public private(set) var assignmentProblemSets: Set<AssignmentProblemSet>?
    @NSManaged public private(set) var lists: Set<List>?
    @NSManaged public private(set) var problemItems: NSOrderedSet
    @NSManaged public private(set) var constituents: [Constituent]
    @NSManaged public private(set) var template: ProblemSetTemplate
    public var normalizedText: String { return "" }
    
}



extension ProblemSet {
    
    public func addNewProblemItem() -> ProblemItem {
        
        let items = mutableProblemItems
        let item = ProblemItem.insertIntoContext(managedObjectContext!)
        items.addObject(item)
        return item
        
    }
    
    
    public func insertNewProblemItemAtIndex(index: Int) -> ProblemItem {
        
        let item = ProblemItem.insertIntoContext(managedObjectContext!)
        mutableProblemItems.insertObject(item, atIndex: index)
        return item
        
    }
    
    
    public func removeProblemItemAtIndex(index: Int) -> ProblemItem? {
        
        guard problemItems.count > 1 else { print("Error: ProblemSet must not have zero ProblemItems"); return nil }
        let item = mutableProblemItems.objectAtIndex(index) as! ProblemItem
        mutableProblemItems.removeObjectAtIndex(index)
        return item
        
    }
    
    
    private var mutableProblemItems: NSMutableOrderedSet {
        return mutableOrderedSetValueForKey("problemItems")
    }
    
    
    public func addNewConstituentWithStyleIdentifier(styleIdentifier: String) -> Constituent {
        
        let constituent = Constituent(styleIdentifier: styleIdentifier)
        constituents.append(constituent)
        return constituent
        
    }
    
}


extension ProblemSet {
    
    public static func insertIntoContext(moc: NSManagedObjectContext, withTemplate template: ProblemSetTemplate) -> ProblemSet {
        
        let problemSet: ProblemSet = moc.insertObject()
        problemSet.template = template
        return problemSet
        
    }
    
}