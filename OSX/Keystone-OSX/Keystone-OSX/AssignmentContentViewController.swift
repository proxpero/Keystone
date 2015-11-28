//
//  AssignmentContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/28/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public class AssignmentContentViewController: NSTabViewController {
    
    public var assignment: Assignment! {
        didSet { title = String(assignment.dueDate) }
    }
}