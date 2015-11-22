//
//  Assignment.swift
//  Example
//
//  Created by Todd Olsen on 11/21/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public struct Assignment {
    
    let assignedOnDate: NSDate
    let dueDate: NSDate
    
    public init(dueDate: NSDate, assignedOnDate: NSDate = NSDate()) {
        self.dueDate = dueDate
        self.assignedOnDate = assignedOnDate
    }
}
