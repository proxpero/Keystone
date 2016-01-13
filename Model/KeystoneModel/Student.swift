//
//  Student.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData


extension Student {
    
    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var graduationDate: NSDate
    @NSManaged public var image: NSData?
    
    @NSManaged public private(set) var assignments: Set<Assignment>
    @NSManaged public private(set) var notes: Set<Note>
 
    public func filter(assignmentType: AssignmentType) -> [Assignment] {
        switch assignmentType {
        case .Overdue:
            return assignments.filter { $0.overdue }.sort { $0.dueDate.compare($1.dueDate) == .OrderedAscending }
        case .Active:
            return assignments.filter { $0.active }.sort { $0.dueDate.compare($1.dueDate) == .OrderedAscending }
        case .Completed:
            return assignments.filter { $0.completed }.sort { $0.dueDate.compare($1.dueDate) == .OrderedDescending }
        }
    }
}

extension Student {
    
    public var fullName: String {
        return "\(firstName) \(lastName)".stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    public func newAssignment() -> Assignment {
        
        let assignment = Assignment.insertIntoContext(managedObjectContext!)
        assignments.insert(assignment)
        return assignment
        
    }
    
    public func addAssignment(assignment: Assignment) {
        self.assignments.insert(assignment)
    }
    
    public func addAssignments<S: SequenceType where S.Generator.Element == Assignment>(newAssignments: S) {
        assignments.unionInPlace(newAssignments)
    }
    
    public func newNote() -> Note {
        let note: Note = managedObjectContext!.insertObject()
        note.timestamp = NSDate()
        notes.insert(note)
        return note
    }
    
    public func removeNote(note: Note) {
        notes.remove(note)
    }

    public func graduationDateString() -> String {
        
        let formatter = graduationDateFormatter
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        
        return formatter.stringFromDate(graduationDate)        
    }
}

private let graduationDateFormatter: NSDateFormatter = {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = .MediumStyle
    dateFormatter.timeStyle = .NoStyle
    
    return dateFormatter
}()


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

public final class Note: ManagedObject, ManagedObjectType { }

extension Note {
    
    @NSManaged public var text: NSAttributedString?
    @NSManaged public var timestamp: NSDate
    
}