//
//  Student.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public final class Student: ManagedObject {
    
    @NSManaged public private(set) var firstName: String
    @NSManaged public private(set) var lastName: String
    @NSManaged public private(set) var graduationDate: NSDate
    @NSManaged public private(set) var assignments: Set<Assignment>

    public func addAssignment(newAssignment: Assignment) {
        assignments.insert(newAssignment)
    }
    
    public func addAssignments(newAssignments: [Assignment]) {
        assignments.unionInPlace(newAssignments)
    }
}

extension Student {
    public var fullName: String { return "\(firstName) \(lastName)" }
}

extension Student: ManagedObjectType {
    
    public static var entityName: String { return "Student" }
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "graduationDate", ascending: true),
            NSSortDescriptor(key: "firstName", ascending: true),
            NSSortDescriptor(key: "lastName", ascending: true)
        ]
    }
    public static var defaultPredicate: NSPredicate { return NSPredicate() }
}

extension Student { // Core Data
    
    public static func insertIntoContext(moc: NSManagedObjectContext) -> Student {
        let student: Student    = moc.insertObject()
        student.firstName       = "First"
        student.lastName        = "Last"
        student.graduationDate  = NSDate()
        return student
    }

    public static func insertIntoContext(moc: NSManagedObjectContext, firstName: String, lastName: String, graduationDate: NSDate) -> Student {
        let student: Student    = moc.insertObject()
        student.firstName       = firstName
        student.lastName        = lastName
        student.graduationDate  = graduationDate
        return student
    }
}


