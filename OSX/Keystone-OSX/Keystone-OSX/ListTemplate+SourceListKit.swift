//
//  ListTemplate+SourceListKit.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/1/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import SourceListKit
import Keystone_Model_OSX

extension ListTemplate: SourceListItemsProvider {
    
    public static func sourceListItemsInContext(context: NSManagedObjectContext) -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        items.append(defaultHeaderItemWithTitle("Lists") { button in
            print("List Header button clicked")
        })
        
        items.appendContentsOf(ListTemplate.fetchInContext(context){ request in
            request.predicate = NSPredicate(format: "parent == nil")
        }.map { $0.dynamicSourceListItem() })
        
        return items
    }
}

extension ListTemplate: DynamicChildProvider { }

extension ListTemplate: DynamicSourceListItemProvider, StaticDetailItemTitleProvider {
    
    public var staticDetailItemTitle: String { return title }
  
    public func dynamicCellSelectionHandler() {
        print("list template \(title)")
    }
    
}

extension ListTemplate: DynamicChildItemTypeProvider {

    public func sourceListConfigurator() -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        // Summary Header

        items.append(defaultHeaderItemWithTitle("Summary"))
        items.append(defaultStaticDetailWithTabIdentifier(ListTemplateControllerItem.Settings.rawValue))
        items.append(defaultStaticDetailWithTabIdentifier(ListTemplateControllerItem.History.rawValue))

        // Lists
        
        if lists.count > 0 {
            
            items.append(defaultHeaderItemWithTitle("Lists") { button in
                print("Lists button clicked")
            })
            items.appendContentsOf(lists.sort { $0.name < $1.name }.map { $0.dynamicSourceListItem() })
        
        }
        
        // Children
        
        if let childTemplates = children?.array as? [ListTemplate] where children?.count > 0 {

            items.append(defaultHeaderItemWithTitle("Children") { button in
                print("Child button clicked")
                })
            items.appendContentsOf(childTemplates.map { $0.dynamicSourceListItem() })
        
        }
        
        return items
    }
    
    
    public func contentViewConfigurator() -> NSViewController {
        guard let vc = NSStoryboard(
            name: "ListTemplateContentView",
            bundle: NSBundle(forClass: ListTemplateContentViewController.self)
            ).instantiateInitialController() as? ListTemplateContentViewController else { fatalError() }
        vc.listTemplate = self
        return vc
    }
    
    
//    public func toolbarConfigurator(toolbar: NSToolbar) {
//        if let label = (toolbar.items.filter { $0.itemIdentifier == "ToolbarLabelItem" }).first?.view as? NSTextField {
//            label.stringValue = title
//        }
//    }
    
}
