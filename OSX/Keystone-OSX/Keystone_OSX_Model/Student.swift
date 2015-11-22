//
//  Student.swift
//  Example
//
//  Created by Todd Olsen on 11/18/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public struct Student {
    let name: String
    let assignments: Set<ProblemAssignment>
    init(name: String, assignments: Set<ProblemAssignment>) {
        self.name = name
        self.assignments = assignments
    }
}
