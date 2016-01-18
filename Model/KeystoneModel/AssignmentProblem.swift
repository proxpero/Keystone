//
//  AssignmentProblem.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData


extension AssignmentProblemSet {
    
    @NSManaged public private(set) var assignment: Assignment
    @NSManaged public private(set) var problemSet: ProblemSet
    @NSManaged public private(set) var assignmentProblemItems: NSOrderedSet
    
    public var completed: Bool {
        guard let items = assignmentProblemItems.array as? [AssignmentProblemItem] else { return false }
        for api in items {
            if api.result == AssignmentProblemResult.None { return false }
        }
        return true
    }
}


extension AssignmentProblemSet {
    
    public static func insertIntoContext(moc: NSManagedObjectContext,
        assignment: Assignment,
        problemSet: ProblemSet)
        -> AssignmentProblemSet {
            let assignmentProblemSet: AssignmentProblemSet = moc.insertObject()
            assignmentProblemSet.assignment = assignment
            assignmentProblemSet.problemSet = problemSet
            for pi in problemSet.problemItems {                
                let api: AssignmentProblemItem = moc.insertObject()
                api.problemItem = pi as! ProblemItem
                api.assignmentProblemSet = assignmentProblemSet
            }
            return assignmentProblemSet
    }
}


public enum AssignmentProblemResult: Int {
    case None       = 0
    case Correct    = 1
    case Incorrect  = 2
    case Omit       = 3
}


extension AssignmentProblemItem {
    
    @NSManaged private private(set) var rawResult: Int16
    @NSManaged public private(set) var assignmentProblemSet: AssignmentProblemSet
    @NSManaged public private(set) var problemItem: ProblemItem
    
    public var result: AssignmentProblemResult {
        get {
            if rawResult > 3 { rawResult = 0 }
            if rawResult < 0 { rawResult = 0 }
            return AssignmentProblemResult(rawValue: Int(rawResult))!
        }
        
        set {
            rawResult = Int16(newValue.rawValue)
        }
    }
}

