//
//  AssignmentContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/28/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public final class AssignmentContentViewController: ContentTabViewController {
    
    public var assignment: Assignment! {
        didSet { title = String(assignment.dueDate) }
    }
    
}

public final class AssignmentViewController: NSViewController {
    
    @IBOutlet weak var label: NSTextField!
    public var assignment: Assignment!
    public override func viewDidLoad() {
        if let assignment = assignment {
            label.stringValue = assignment.dueDate.since()
        }
    }
}