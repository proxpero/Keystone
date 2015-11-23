//
//  WindowController.swift
//  Example
//
//  Created by Todd Olsen on 11/19/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.contentView?.wantsLayer = true
        window?.titleVisibility = .Hidden
    }
}

