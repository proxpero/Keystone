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
    @NSManaged public private(set) var template: ListTemplate
    @NSManaged public private(set) var parent: List?
    @NSManaged public private(set) var children: NSOrderedSet?
    @NSManaged public private(set) var problemSets: NSOrderedSet?

    public func addNewChildListWithName(name: String, childTemplate: ListTemplate) -> List {
        guard let childTemplates = template.children?.array as? [ListTemplate] else { fatalError() }
        guard childTemplates.contains(childTemplate) else { fatalError() }
        
        let list = List.insertIntoContext(managedObjectContext!, name: name, template: childTemplate)
        list.parent = self
        
        return list
        
    }
    
    public func addProblemSet(problemSet: ProblemSet) {
        let mutableSets = mutableOrderedSetValueForKey("problemSets")
        mutableSets.addObject(problemSet)
    }
    
    public func insertProblemSet(problemSet: ProblemSet, atIndex index: Int) {
        let mutableSets = mutableOrderedSetValueForKey("problemSets")
        mutableSets.insertObject(problemSet, atIndex: index)
    }
}

extension List: ManagedObjectType {
    
    public static var entityName: String { return "List" }
    public static var defaultSortDescriptors: [NSSortDescriptor] { return [] }
    public static var defaultPredicate: NSPredicate { return NSPredicate() }

}

extension List {
    
    public static func insertIntoContext(moc: NSManagedObjectContext, name: String, template: ListTemplate) -> List {
        
        let list: List = moc.insertObject()
        list.name = name
        list.template = template
        
        return list
    }
}