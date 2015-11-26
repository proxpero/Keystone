//
//  StudentContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_OSX_Model

public enum StudentViewControllerItems: Int {
    case Personal
    case History
    case Assignments
}

public class StudentContentViewController: NSTabViewController {
    public var student: Student! {
        didSet { title = student.fullName }
    }
}

class StudentPersonalProfileViewController: NSViewController {
    
    
    
}

class StudentHistoryViewController: NSViewController {
    
}