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

extension ListTemplate: DynamicChildProvider {
    
    public func dynamicSourceListItem() -> SourceListItem {
        return SourceListItem(
            itemType:               dynamicChildItemType(),
            cellViewConfigurator:   dynamicCellViewConfigurator,
            cellSelectionCallback:  dynamicCellSelectionCallback)
    }
}

extension ListTemplate {
    
    func dynamicChildItemType() -> SourceListItemType {
        return .DynamicChild(
            sourceListConfigurator:     sourceListConfigurator,
            contentViewConfigurator:    contentViewConfigurator,
            toolbarConfigurator:        toolbarConfigurator)
    }
    
    func sourceListConfigurator() -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        // Summary Header

        items.append(defaultHeaderItemWithTitle("Summary"))
        items.append(defaultStaticDetailWithIdentifier(ListTemplateControllerItem.Settings.rawValue))
        items.append(defaultStaticDetailWithIdentifier(ListTemplateControllerItem.History.rawValue))

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
    
    func contentViewConfigurator() -> NSViewController {
        guard let vc = NSStoryboard(
            name: "ListTemplateContentView",
            bundle: NSBundle(forClass: ListTemplateContentViewController.self)
            ).instantiateInitialController() as? ListTemplateContentViewController else { fatalError() }
        vc.listTemplate = self
        return vc
    }
    
    func toolbarConfigurator(toolbar: NSToolbar) {
        if let label = (toolbar.items.filter { $0.itemIdentifier == "ToolbarLabelItem" }).first?.view as? NSTextField {
            label.stringValue = name
        }
    }
    
    func dynamicCellViewConfigurator(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
        view.textField?.stringValue = name
        return view
    }
    
    func dynamicCellSelectionCallback() {
        print("list template \(name)")
    }
}

extension ListTemplate {
    
    static func cellViewConfigurator(listTemplate: ListTemplate)(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
        view.textField?.stringValue = listTemplate.name
        return view
    }
    
    static func contentViewControllerConfigurator(listTemplate: ListTemplate)() -> NSViewController {
        guard let vc = NSStoryboard(name: "ListTemplateContentView", bundle: NSBundle(forClass: ListTemplateContentViewController.self)).instantiateInitialController() as? ListTemplateContentViewController else { fatalError() }
        vc.listTemplate = listTemplate
        return vc
    }

    static func sourceListConfigurator(listTemplate: ListTemplate) -> [SourceListItem] {
        
        var items: [SourceListItem] = []

        // Profile Header
        //      Static Item: Constituents
        //      Static Item: Statistics
        
        func configureProfileHeaderCell(tableView: NSTableView) -> NSTableCellView {
            guard let headerCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Header, owner: tableView) as? SourceListHeaderCellView else { fatalError() }
            headerCell.textField?.stringValue = "List Template"
            headerCell.showHiddenViews = false
            return headerCell
        }
        
        // Template Instances Header
        //      Children: Lists of current template
        
        
        // (if children.count > 0) Template Children Header
        //      Children: child template of current template
        
        return items
        
    }
}