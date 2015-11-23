//: [Previous](@previous)

import Foundation
import Keystone_OSX_Model
import MacUtilities

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

func randomStudent() -> Student {
    
    let name = Person.randomFirstName() + " " + Person.randomLastName()
    let oneYear = Double(60*60*24*365)
    let graduationDate = NSDate(timeIntervalSinceNow: NSTimeInterval(oneYear*Double(arc4random_uniform(15)) - oneYear*(15 * 3/4)))
    func assignments() -> Set<Assignment> {
        
        var startDate = graduationDate.dateByAddingTimeInterval(-1.0*60*60*24*7*4*9)
        
        var assignments = Set<Assignment>()
        for n in (0...36) {
            
            startDate = startDate.dateByAddingTimeInterval(Double(n))
            let dates = randomDatesBeforeAndAfterDate(startDate, weeksApart: Double(arc4random_uniform(3)))
            
            let assignment = Assignment(
                note: randomNote(),
                dueDate: dates.after,
                assignedOnDate: dates.before,
                problemAssignments: randomProblemAssignments())
            assignments.insert(assignment)
            
        }
        
        return assignments
    }
    
    return Student(
        name: name,
        graduationDate: graduationDate,
        assignments: assignments())
}

let s = randomStudent()
//
//let oneYear = Double(60*60*24*365)
//var dates = [NSDate]()
//for _ in (1...100) {
//
//let graduationDate = NSDate(timeIntervalSinceNow: NSTimeInterval(oneYear*Double(arc4random_uniform(15)) - oneYear*(15 * 3/4)))
//    dates.append(graduationDate)
//
//}
//
//dates.sortInPlace { (date1, date2) in
//    return date1.timeIntervalSinceReferenceDate < date2.timeIntervalSinceReferenceDate
//}




//: [Next](@next)
