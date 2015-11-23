//
//  Assignment.swift
//  Example
//
//  Created by Todd Olsen on 11/21/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public struct Assignment {
    
    let student: Student
    let note: String
    let assignedOnDate: NSDate
    let dueDate: NSDate
    var assignmentProblems: [ProblemAssignment]
    
    public init(
        student: Student,
        note: String,
        dueDate: NSDate,
        assignedOnDate: NSDate = NSDate(),
        assignmentProblems: [ProblemAssignment] = [])
    {
        self.student            = student
        self.note               = note
        self.dueDate            = dueDate
        self.assignedOnDate     = assignedOnDate
        self.assignmentProblems = assignmentProblems
    }
}

extension Assignment: Equatable { }
public func ==(lhs: Assignment, rhs: Assignment) -> Bool {
    
    if lhs.dueDate                  != rhs.dueDate                  { return false }
    if lhs.assignedOnDate           != rhs.assignedOnDate           { return false }
    if lhs.assignmentProblems.count != rhs.assignmentProblems.count { return false }
    if lhs.assignmentProblems       != rhs.assignmentProblems       { return false }
    
    return true
}

extension Assignment: Hashable {
    public var hashValue: Int { return dueDate.hashValue * assignedOnDate.hashValue }
}

extension Assignment: CustomStringConvertible {
    static let formatter: NSDateFormatter = {
        let df = NSDateFormatter()
        df.dateStyle = NSDateFormatterStyle.ShortStyle
        df.timeStyle = NSDateFormatterStyle.NoStyle
        return df
    }()
    public var description: String { return "\(assignmentProblems.count) assignments, due on \(Assignment.formatter.stringFromDate(dueDate))" }
}