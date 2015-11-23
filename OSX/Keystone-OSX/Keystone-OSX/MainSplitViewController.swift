//
//  MainSplitViewController.swift
//  Example
//
//  Created by Todd Olsen on 11/19/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard splitViewItems.count == 2 else { fatalError() }
        guard let sourceListSplitViewItem = splitViewItems.first else { fatalError() }
        sourceListSplitViewItem.preferredThicknessFraction  = 0.18
        sourceListSplitViewItem.canCollapse                 = false
        sourceListSplitViewItem.maximumThickness            = 300
        sourceListSplitViewItem.minimumThickness            = 200
        sourceListSplitViewItem.holdingPriority             = NSLayoutPriorityDefaultLow + 10.0
        sourceListSplitViewItem.springLoaded                = true
        
        guard let mainSideBarViewController = sourceListSplitViewItem.viewController as? SourceListTabViewController else { fatalError("No Sidebar View") }
        guard let mainContentViewController = splitViewItems.last?.viewController as? ContentTabViewController else { fatalError("No Content View") }
    
        mainSideBarViewController.pushContentViewControllerHandler = { viewController in
            mainContentViewController.newContentViewController(viewController)
        }    
    }
}

class TKOSplitView: NSSplitView {
    var customDividerColor: NSColor?
    override var dividerColor: NSColor {
        guard customDividerColor != nil else { return super.dividerColor }
        return customDividerColor!
    }
}