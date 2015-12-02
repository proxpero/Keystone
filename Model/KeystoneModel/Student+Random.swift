//
//  Student+Random.swift
//  Keystone
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData
import UtilityKit_OSX

extension Student {
    
    public static func randomInContext(moc: NSManagedObjectContext) -> Student {
        
        let firstName       = Person.randomFirstName()
        let lastName        = Person.randomLastName()
        let graduationDate  = NSDate.randomDate(weeksAgo: -4, offset: 10)
        
        let problemSets = ProblemSet.fetchInContext(moc)
        let c = UInt32(problemSets.count)
        
        let student = Student.insertIntoContext(moc,
            firstName:      firstName,
            lastName:       lastName,
            graduationDate: graduationDate)
        
        for w in (0...Int(arc4random_uniform(35) + 5)) {
            
            let assignedOn  = graduationDate.randomDate(weeks: -w, rangeInDays: 4)
            let dueDate     = assignedOn.randomDate(weeks: 2, rangeInDays: 2)
            let assignment  = Assignment.insertIntoContext(moc,
                name:       NSUUID().UUIDString.componentsSeparatedByString("-").first!,
                assignedOn: assignedOn,
                dueDate:    dueDate)
            
            for _ in (0...Int(arc4random_uniform(7) + 7)) {
                
                let problemSet = problemSets[Int(arc4random_uniform(c))]
                
                let assignmentProblemSet = AssignmentProblemSet.insertIntoContext(moc,
                    assignment: assignment,
                    problemSet: problemSet)
                
                for api in assignmentProblemSet.assignmentProblemItems.array as! [AssignmentProblemItem] {
                    api.result = AssignmentProblemResult(rawValue: assignment.dueDate <= NSDate() ? Int(arc4random_uniform(2) + 1) : 0)!
                }
            }
            
            student.addAssignment(assignment)
        }
        
        return student
    }
}
