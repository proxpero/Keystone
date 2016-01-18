//
//  ListTemplate.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/1/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public final class ListTemplate: ManagedObject, ManagedObjectType { }

extension ListTemplate {
    
    @NSManaged public               var title:      String
    @NSManaged public               var header:     NSAttributedString?
    @NSManaged public               var footer:     NSAttributedString?
    @NSManaged public private(set)  var lists:      Set<List>
    @NSManaged public private(set)  var parent:     ListTemplate?
    @NSManaged public private(set)  var children:   NSOrderedSet?

    public func addNewChildWithTitle(title: String) -> ListTemplate {
        
        let child = ListTemplate.insertIntoContext(managedObjectContext!, title: title)
        child.parent = self
     
        return child
    }
    
    public func insertNewChildWithName(title: String, atIndex index: Int) -> ListTemplate {
        guard index >= 0 && index < children?.count else { fatalError() }

        let child = ListTemplate.insertIntoContext(managedObjectContext!, title: title)
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


extension ListTemplate {
    
    public static func insertIntoContext(moc: NSManagedObjectContext, title: String) -> ListTemplate {
        
        let listTemplate: ListTemplate = moc.insertObject()
        listTemplate.title = title
        return listTemplate
        
    }
 
    public func newListWithName(name: String) -> List {
        return List.insertIntoContext(managedObjectContext!, name: name, template: self)
    }
}