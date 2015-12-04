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

extension List: DynamicChildProvider {
    
    public func dynamicSourceListItem() -> SourceListItem {
        return SourceListItem(
            itemType: dynamicChildItemType(),
            cellViewConfigurator: defaultStaticDetailConfiguratorWithTitle(name))
    }
    
    func dynamicChildItemType() -> SourceListItemType {
        return .DynamicChild(
            sourceListConfigurator: sourceListConfigurator,
            contentViewConfigurator: contentViewConfigurator,
            toolbarConfigurator: toolbarConfigurator)
    }

    func sourceListConfigurator() -> [SourceListItem] {
        
        var items: [SourceListItem] = []
  
        // Summary Header
        
        items.append(defaultHeaderItemWithTitle("Summary"))
        items.append(defaultStaticDetailWithIdentifier(ListControllerItem.Settings.rawValue))
        items.append(defaultStaticDetailWithIdentifier(ListControllerItem.History.rawValue))
        
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

    func contentViewConfigurator() -> NSViewController {
        guard let vc = NSStoryboard(name: "ListContentView", bundle: NSBundle(forClass: ListContentViewController.self)).instantiateInitialController() as? ListContentViewController else { fatalError() }
        vc.list = self
        return vc
    }
    
    func toolbarConfigurator(toolbar: NSToolbar) {
        if let label = (toolbar.items.filter { $0.itemIdentifier == "ToolbarLabelItem" }).first?.view as? NSTextField {
            label.stringValue = name
        }
    }
    
}

