//
//  ContentTabViewController.swift
//  Example
//
//  Created by Todd Olsen on 11/20/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa

public protocol StaticChildViewControllerType {
    
    func newContentViewController(viewController: NSViewController) -> ()
    func selectTabItemWithIdentifier(identifier: String) -> NSTabViewItem?
    
}

public class ContentTabViewController: NSTabViewController, StaticChildViewControllerType {
//    public var managedObjectContext: NSManagedObjectContext!
    
    public func newContentViewController(viewController: NSViewController) {
        
        let tabViewItem = NSTabViewItem(viewController: viewController)
        insertTabViewItem(tabViewItem, atIndex: 0)
        selectedTabViewItemIndex = 0
        
        if tabViewItems.count > 1 {
            removeTabViewItem(tabViewItems[1])
        }
    
    }
    
    public func selectTabItemWithIdentifier(identifier: String) -> NSTabViewItem? {
        if let
            tvi = (tabViewItems.filter { $0.identifier as? String == identifier }).first,
            index = tabViewItems.indexOf(tvi)
        {
            selectedTabViewItemIndex = index
            return tvi
        }
        return nil
    }
}
