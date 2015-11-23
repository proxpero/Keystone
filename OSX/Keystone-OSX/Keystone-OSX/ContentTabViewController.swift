//
//  ContentTabViewController.swift
//  Example
//
//  Created by Todd Olsen on 11/20/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa

public class ContentTabViewController: NSTabViewController {
    
    func newContentViewController(viewController: NSViewController) {
        
        let tabViewItem = NSTabViewItem(viewController: viewController)
        insertTabViewItem(tabViewItem, atIndex: 0)
        selectedTabViewItemIndex = 0

    }
}