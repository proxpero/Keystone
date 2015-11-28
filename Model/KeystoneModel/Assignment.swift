//
//  Assignment.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public final class Assignment: ManagedObject {


}

extension Assignment {
    
    @NSManaged public private(set) var assignedOn: NSDate
    @NSManaged public private(set) var dueDate: NSDate
    @NSManaged public private(set) var note: String
    @NSManaged public private(set) var assignmentProblemSets: NSOrderedSet
    @NSManaged public private(set) var students: Set<Student>
    
}

extension Assignment {
    
    public func addProblemSet(
        
        problemSet: ProblemSet)
        
        -> AssignmentProblemSet
    {
        let assignmentProblemSet = AssignmentProblemSet.insertIntoContext(managedObjectContext!, assignment: self, problemSet: problemSet)
        mutableAssignmentProblemSets().addObject(assignmentProblemSet)
        return assignmentProblemSet
    }
    
    public func insertProblemSet(
        
        problemSet:         ProblemSet,
        atIndex     index:  Int)
        
        -> AssignmentProblemSet
    {
        let assignmentProblemSet = AssignmentProblemSet.insertIntoContext(managedObjectContext!, assignment: self, problemSet: problemSet)
        mutableAssignmentProblemSets().insertObject(assignmentProblemSet, atIndex: index)
        return assignmentProblemSet
    }
    
    public func removeProblemSetAtIndex(index: Int) {
        mutableAssignmentProblemSets().removeObjectAtIndex(index)
    }
    
    private func mutableAssignmentProblemSets() -> NSMutableOrderedSet {
        return mutableOrderedSetValueForKey("assignmentProblemSets")
    }
}

extension Assignment: ManagedObjectType {
    
    public static var entityName: String { return "Assignment" }
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "dueDate", ascending: true),
            NSSortDescriptor(key: "assignedOn", ascending: true),
            NSSortDescriptor(key: "note", ascending: true)
        ]
    }
    public static var defaultPredicate: NSPredicate { return NSPredicate() }
}

extension Assignment {
    
    public static func insertIntoContext(
        
        moc: NSManagedObjectContext)
        
        -> Assignment
    {
        let assignment: Assignment  = moc.insertObject()
        
        assignment.assignedOn       = NSDate(timeIntervalSince1970: 0)
        assignment.dueDate          = NSDate(timeIntervalSince1970: 1)
        assignment.note             = ""
        
        return assignment
    }
    
    
    public static func insertIntoContext(
        
        moc:        NSManagedObjectContext,
        assignedOn: NSDate,
        dueDate:    NSDate)
        
        -> Assignment
    {
        let assignment: Assignment  = moc.insertObject()
        
        assignment.assignedOn       = assignedOn
        assignment.dueDate          = dueDate
        assignment.note             = ""
        
        return assignment
    }
}