//
//  ManagedObjectType+Model.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/7/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public final class Student: ManagedObject, ManagedObjectType { }
public final class Assignment: ManagedObject, ManagedObjectType { }
public final class AssignmentProblemSet: ManagedObject, ManagedObjectType { }
public final class AssignmentProblemItem: ManagedObject, ManagedObjectType { }
public final class List: ManagedObject, ManagedObjectType { }
public final class ProblemSet: ManagedObject, ManagedObjectType { }
public final class ProblemSetTemplate: ManagedObject, ManagedObjectType { }
public final class ProblemItem: ManagedObject, ManagedObjectType { }
//public final class ConstituentStyle: ManagedObject, ManagedObjectType { }


extension ManagedObjectType {
    
    public static var entityName: String { return String(self) }
    public static var defaultSortDescriptors: [NSSortDescriptor] { return [] }
    public static var defaultPredicate: NSPredicate { return NSPredicate(value: true) }
    
}

extension ManagedObjectType where Self: Student {

    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "firstName", ascending: true),
            NSSortDescriptor(key: "lastName", ascending: true)
        ]
    }
    
    public static var defaultPredicate: NSPredicate {
        return NSPredicate(format: "graduationDate > %@", NSDate())
    }
    
}


extension ManagedObjectType where Self: Note {
    
    public static var defaultSortDescriptors: [NSSortDescriptor] { return [NSSortDescriptor(key: "timestamp", ascending: true)] }

}


extension ManagedObjectType where Self: Assignment {
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "dueDate", ascending: true),
            NSSortDescriptor(key: "assignedOn", ascending: true),
            NSSortDescriptor(key: "note", ascending: true)
        ]
    }
    
}




extension ManagedObjectType where Self: ListTemplate { }
