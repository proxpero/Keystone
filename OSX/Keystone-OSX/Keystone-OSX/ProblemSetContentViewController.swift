//
//  ProblemSetContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/3/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public final class ProblemSetContentViewController: ContentTabViewController {
    
    public var problemSet: ProblemSet!
    
}

public final class ProblemSetViewController: NSViewController {
    
    public var problemSet: ProblemSet! {
        didSet {
            print("\(problemSet)")
        }
    }
    
}