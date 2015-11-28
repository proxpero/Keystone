//
//  Student+Random.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

extension Student {
    
    public static func randomInContext(moc: NSManagedObjectContext) -> Student {
        
        let firstName   = Person.randomFirstName()
        let lastName    = Person.randomLastName()
        let graduationDate = NSDate.randomDate(yearsAgo: 20, offset: 4)
        
        let student = Student.insertIntoContext(moc,
            firstName: firstName,
            lastName: lastName,
            graduationDate: graduationDate)
        
        for w in (0...Int(arc4random_uniform(15) + 30)) {
            
            let assignedOn = graduationDate.randomDate(weeks: -w, rangeInDays: 4)
            let dueDate = assignedOn.randomDate(weeks: 2, rangeInDays: 2)
            let assignment = Assignment.insertIntoContext(moc,
                assignedOn: assignedOn,
                dueDate: dueDate)
            
            let template = ProblemSetTemplate.insertIntoContext(moc)
            
            for _ in (0...Int(arc4random_uniform(10) + 15)) {
                
                let problemSet = ProblemSet.insertIntoContext(moc, withTemplate: template)
                let assignmentProblemSet = AssignmentProblemSet.insertIntoContext(moc,
                    assignment: assignment,
                    problemSet: problemSet)
                
                for api in assignmentProblemSet.assignmentProblemItems.array as! [AssignmentProblemItem] {
                    api.result = AssignmentProblemResult(rawValue:Int(arc4random_uniform(2) + 1))!
                }
            }
            
            student.addAssignment(assignment)
        }
        
        
        
        return student
    }
}
