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
    var manualDifficulty: Double?
    let history: ProblemHistory
    var problemAssignments: Set<ProblemAssignment>
    
    init(
        question: String,
        manualDifficulty: Double?,
        history: ProblemHistory                     = ProblemHistory(),
        problemAssignments: Set<ProblemAssignment>  = [])
    {
        self.question                               = question
        self.manualDifficulty                       = manualDifficulty
        self.history                                = history
        self.problemAssignments                     = problemAssignments
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

public struct ProblemHistory {
    
    let correctResponses: Int
    let incorrectResponses: Int
    let totalResponses: Int
    
    public init(
        correctResponses: Int   = 0,
        incorrectResponses: Int = 0,
        totalResponses: Int     = 0)
    {
        self.correctResponses   = correctResponses
        self.incorrectResponses = incorrectResponses
        self.totalResponses     = totalResponses
    }
    
    var historicalDifficulty: Double {
        guard totalResponses > 0 else { return 0.0 }
        return (Double(correctResponses) - (0.25)*Double(incorrectResponses)) / Double(totalResponses)
    }
}


