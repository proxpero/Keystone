//
//  MainSplitViewController.swift
//  Example
//
//  Created by Todd Olsen on 11/19/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public class MainSplitViewController: NSSplitViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    
    public func save(sender: AnyObject?) {
        do {
            try managedObjectContext.save()
            print("Success")
        } catch {
            print("ERROR!")
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        guard let mainSidebarViewController = splitViewItems.first?.viewController as? SourceListTabViewController else { fatalError("No Sidebar View") }
        guard let mainContentViewController = splitViewItems.last?.viewController as? ContentTabViewController else { fatalError("No Content View") }
        guard let context = createKeystoneMainContext() else { fatalError() }
        
        managedObjectContext = context
        
        mainSidebarViewController.managedObjectContext = managedObjectContext
        mainContentViewController.managedObjectContext = managedObjectContext
        
        mainSidebarViewController.pushContentViewControllerHandler = { viewController in
            mainContentViewController.newContentViewController(viewController)
        }
        
        configureSplitView()
        
        let populate = true
        if populate {
            for _ in (0..<5) {
                Student.randomInContext(managedObjectContext)
            }
        }
        mainSidebarViewController.instantiateRoot()
    }
    
    private func configureSplitView() {
        guard splitViewItems.count == 2 else { fatalError() }
        guard let sourceListSplitViewItem = splitViewItems.first else { fatalError() }
        sourceListSplitViewItem.preferredThicknessFraction  = 0.18
        sourceListSplitViewItem.canCollapse                 = false
        sourceListSplitViewItem.maximumThickness            = 300
        sourceListSplitViewItem.minimumThickness            = 200
        sourceListSplitViewItem.holdingPriority             = NSLayoutPriorityDefaultLow + 10.0
        sourceListSplitViewItem.springLoaded                = true
    }
}

class TKOSplitView: NSSplitView {
    var customDividerColor: NSColor?
    override var dividerColor: NSColor {
        guard customDividerColor != nil else { return super.dividerColor }
        return customDividerColor!
    }
}