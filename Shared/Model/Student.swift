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
    let graduationDate: NSDate
    let assignments: Set<Assignment>
    
    public init(
        name: String,
        graduationDate: NSDate,
        assignments: Set<Assignment>)
    {
        self.name           = name
        self.graduationDate = graduationDate
        self.assignments    = assignments
    }
}

extension Student: CustomStringConvertible {
    
    public var description: String {
        return "\(name), graduation date \(graduationDate), assingments: \(assignments)"
    }
}