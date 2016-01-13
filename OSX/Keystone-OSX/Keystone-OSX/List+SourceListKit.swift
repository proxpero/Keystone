//
//  List+SourceListKit.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/1/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import SourceListKit
import Keystone_Model_OSX

extension List: StaticDetailItemTitleProvider {
    public var staticDetailItemTitle: String { return name }
}

extension List: DynamicChildProvider {
    
    public func sourceListConfigurator() -> [SourceListItem] {
        
        var items: [SourceListItem] = []
  
        // Summary Header
        
        items.append(defaultHeaderItemWithTitle("Summary"))
        items.append(defaultStaticDetailWithTabIdentifier(ListControllerItem.Settings.rawValue))
        items.append(defaultStaticDetailWithTabIdentifier(ListControllerItem.History.rawValue))
        
        // Children
        
        if let childLists = children?.array as? [List] where children?.count > 0 {
            
            items.append(defaultHeaderItemWithTitle("Child Lists"))
            items.appendContentsOf(childLists.map { $0.dynamicSourceListItem() })
        }
        
        // Problems
        
        if let problems = problemSets?.array as? [ProblemSet] where problemSets?.count > 0 {
            
            items.append(defaultHeaderItemWithTitle("Problem Sets"))
            items.appendContentsOf(problems.map { $0.staticChildViewControllerSourceListItem() })
            
        }
        
        return items
    }

    public func contentViewConfigurator() -> NSViewController {
        guard let vc = NSStoryboard(name: "ListContentView", bundle: NSBundle(forClass: ListContentViewController.self)).instantiateInitialController() as? ListContentViewController else { fatalError() }
        vc.list = self
        return vc
    }
    
    public func toolbarConfigurator(toolbar: NSToolbar) {
        if let label = (toolbar.items.filter { $0.itemIdentifier == "ToolbarLabelItem" }).first?.view as? NSTextField {
            label.stringValue = name
        }
    }
    
}

