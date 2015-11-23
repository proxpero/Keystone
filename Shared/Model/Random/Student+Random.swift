//
//  Student+Random.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/22/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import MacUtilities

extension Student: RandomModelObject {
    
    public static func random() -> Student {
        
        let name = Person.randomFirstName() + " " + Person.randomLastName()
        let graduationDate = NSDate(timeIntervalSinceNow: NSTimeInterval(60*60*24*365*Double(arc4random_uniform(15))))
        func assignments() -> Set<Assignment> {
            
            var startDate = graduationDate
            
            var assignments = Set<Assignment>()
            for n in Double(-9*4).stride(through: 0, by: (1 - (drand48()/15))) {
                
                startDate = startDate.dateByAddingTimeInterval(n)
                let dates = randomDatesBeforeAndAfterDate(startDate, weeksApart: Double(arc4random_uniform(3)))
                
                assignments.insert(Assignment(
                    note: randomNote(),
                    dueDate: dates.after,
                    assignedOnDate: dates.before,
                    problemAssignments: randomProblemAssignments()))
                
            }
            
            return assignments
        }
        
        return Student(
            name: name,
            graduationDate: graduationDate,
            assignments: assignments())
    }
}

private func randomNote() -> String {
    var text = String(UnicodeScalar(Int(arc4random_uniform(26)) + 65))
    for _ in 1...Int(arc4random_uniform(100) + 150) {
        var n = 0
        switch Int(arc4random_uniform(3)) {
        case 1:     n = Int(arc4random_uniform(26)) + 97
        case 2:     n = Int(arc4random_uniform(26)) + 97
        default:    n = 32
        }
        text = text + String(UnicodeScalar(n))
        text = text.stringByReplacingOccurrencesOfString("  ", withString: " ")
    }
    return text
}

func randomDatesBeforeAndAfterDate(referenceDate: NSDate, weeksApart weeks: Double) -> (before: NSDate, after: NSDate) {
    let interval = NSTimeInterval(60*60*24*7*0.5*(1 + (drand48()/10))) * weeks
    let before = NSDate(timeInterval: -1.0 * interval, sinceDate: referenceDate)
    let after = NSDate(timeInterval: 1.0 * interval, sinceDate: referenceDate)
    return (before, after)
}

func randomProblemAssignments() -> [ProblemAssignment] {
    return []
}