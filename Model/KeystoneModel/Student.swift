//
//  Student.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public final class Student: ManagedObject {


}

extension Student {
    
    @NSManaged public private(set) var firstName: String
    @NSManaged public private(set) var lastName: String
    @NSManaged public private(set) var graduationDate: NSDate
    @NSManaged public private(set) var assignments: Set<Assignment>
}

extension Student {
    public var fullName: String {
        return "\(firstName) \(lastName)".stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    public func addAssignment(assignment: Assignment) {
        self.assignments.insert(assignment)
    }
    
    public func addAssignments<S: SequenceType where S.Generator.Element == Assignment>(newAssignments: S) {
        assignments.unionInPlace(newAssignments)
    }
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

extension Student {
    
    public static func insertIntoContext(moc: NSManagedObjectContext) -> Student {
        let student: Student    = moc.insertObject()
        student.firstName       = ""
        student.lastName        = ""
        student.graduationDate  = NSDate(timeIntervalSince1970: 0)
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