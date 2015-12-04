//
//  ListTemplateContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/1/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public enum ListTemplateControllerItem: String {
    // these names must correspond to contentTabViewController's tabViewItem identifiers as set in the storyboard
    case Settings   = "Settings"
    case History    = "History"
}

public class ListTemplateContentViewController: ContentTabViewController {
    
    var listTemplate: ListTemplate!
    deinit {
        print("deinit list template")
    }
}