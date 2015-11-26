//
//  Assignment.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData

public final class Assignment: ManagedObject {
    
    @NSManaged public private(set) var assignmentDate: NSDate
    @NSManaged public private(set) var dueDate: NSDate
    @NSManaged public private(set) var note: String?
    @NSManaged public private(set) var student: Student
    @NSManaged public private(set) var assignmentProblems: NSOrderedSet
    
    public func addAssignmentProblem(assignmentProblem: AssignmentProblem) {
        let prbs = mutableOrderedSetValueForKey("assignmentProblems")
        prbs.addObject(assignmentProblem)
    }
}

