//
//  Problem.swift
//  Example
//
//  Created by Todd Olsen on 11/21/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public struct Problem {
    
    let question: String
    var problemAssignments: Set<ProblemAssignment>
    
    init(question: String, problemAssignments: Set<ProblemAssignment>) {
        self.question = question
        self.problemAssignments = problemAssignments
    }
}

public struct ProblemAssignment {
    let problem: Problem
    let assignment: Assignment
}

public func ==(lhs: Problem, rhs: Problem) -> Bool {
    return lhs.question == rhs.question
}

public func ==(lhs: ProblemAssignment, rhs: ProblemAssignment) -> Bool {
    return lhs.problem == rhs.problem
}

extension Problem: Hashable {
    public var hashValue: Int { return question.hashValue }
}

extension ProblemAssignment: Hashable {
    public var hashValue: Int { return problem.question.hashValue }
}
