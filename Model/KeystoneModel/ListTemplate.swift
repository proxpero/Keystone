//
//  ListTemplate.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/1/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public final class ListTemplate: ManagedObject { }

extension ListTemplate {
    
    @NSManaged public private(set) var name:        String
    @NSManaged public private(set) var defaults:    [Constituent]?
    @NSManaged public private(set) var header:      [Constituent]?
    @NSManaged public private(set) var footer:      [Constituent]?
    @NSManaged public private(set) var lists:       Set<List>
 
    @NSManaged public private(set) var parent: ListTemplate?
    @NSManaged public private(set) var children: NSOrderedSet?

    public func addNewChildWithName(name: String) -> ListTemplate {
        
        let child = ListTemplate.insertIntoContext(managedObjectContext!, name: name)
        child.parent = self
     
        return child
    }
    
    public func insertNewChildWithName(name: String, atIndex index: Int) -> ListTemplate {
        guard index >= 0 && index < children?.count else { fatalError() }

        let child = ListTemplate.insertIntoContext(managedObjectContext!, name: name)
        let mutableChildren = mutableOrderedSetValueForKey("children")
        mutableChildren.insertObject(child, atIndex: index)
        
        return child
        
    }
    
    public func addNewListWithName(name: String) -> List {
        
        let list = List.insertIntoContext(managedObjectContext!, name: name, template: self)
        lists.insert(list)

        return list
        
    }
}

extension ListTemplate: ManagedObjectType {
    
    public static var entityName: String { return "ListTemplate" }
    public static var defaultSortDescriptors: [NSSortDescriptor] { return [] }
    public static var defaultPredicate: NSPredicate { return NSPredicate() }
    
}

extension ListTemplate {
    
    public static func insertIntoContext(moc: NSManagedObjectContext, name: String) -> ListTemplate {
        
        let listTemplate: ListTemplate = moc.insertObject()
        listTemplate.name = name
        return listTemplate
        
    }
 
    public func newListWithName(name: String) -> List {
        return List.insertIntoContext(managedObjectContext!, name: name, template: self)
    }
}