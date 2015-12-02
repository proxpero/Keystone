//
//  ListContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/2/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public enum ListControllerItem: String {
    case Settings   = "Settings"
    case History    = "History"
}

public class ListContentViewController: ContentTabViewController {
    
    var list: List!
    
}
