//
//  Student+SourceListKit.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import SourceListKit
import Keystone_Model_OSX
import UtilityKit_OSX

extension Student: DynamicChildProvider { }
extension Student: SourceListItemsProvider {

    public func dynamicCellViewConfigurator(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
        view.textField?.stringValue = fullName
        view.imageView?.image = NSImage(named: "TKOSingleStudent")
        return view
    }
    
    public func dynamicCellSelectionHandler() {
        print("Hi, I'm \(fullName)")
    }

}

extension Student: DynamicChildItemTypeProvider{

    public func sourceListConfigurator() -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        // Profile Header

        items.append(defaultHeaderItemWithTitle("Summary"))
        items.append(defaultStaticDetailWithTabIdentifier(StudentViewControllerItem.Profile.rawValue))
        items.append(defaultStaticDetailWithTabIdentifier(StudentViewControllerItem.History.rawValue))
        
        // Overdue Assignments
        
        let overdue = assignments.filter { $0.overdue }.sort { $0.dueDate.compare($1.dueDate) == .OrderedAscending }
        if overdue.count > 0 {
            
            items.append(SourceListItem(
                itemType: .Header,
                cellViewConfigurator: AssignmentType.Overdue.headerCellWithAssignmentsCount(overdue.count)(identifier: SourceListKitConstants.CellIdentifier.Header)))

            items.appendContentsOf(overdue.map { $0.dynamicSourceListItem() })
        }

        // Active Assignments
        
        let active = assignments.filter { $0.active }.sort { $0.dueDate.compare($1.dueDate) == .OrderedAscending }
        if active.count > 0 {
            
            items.append(SourceListItem(
                itemType: .Header,
                cellViewConfigurator: AssignmentType.Active.headerCellWithAssignmentsCount(active.count)(identifier: SourceListKitConstants.CellIdentifier.Header)) {
                    print("Hey! I'm an active assignment")
                })
            
            items.appendContentsOf(active.map { $0.dynamicSourceListItem() })
        }
        
        // Completed Assignments
        
        let completed = assignments.filter { $0.completed }.sort { $0.dueDate.compare($1.dueDate) == .OrderedDescending }
        if completed.count > 0 {
            
            items.append(SourceListItem(
                itemType: .Header,
                cellViewConfigurator: AssignmentType.Completed.headerCellWithAssignmentsCount(completed.count)(identifier: SourceListKitConstants.CellIdentifier.Header)) {
                    print("a completed assignemnt was selected!")
                })
            
            items.appendContentsOf(completed.map { $0.dynamicSourceListItem() })
        }

        return items
    }
    
    
    public func contentViewConfigurator() -> NSViewController {
        guard let vc = NSStoryboard(name: "StudentContentView", bundle: NSBundle(forClass: StudentContentViewController.self)).instantiateInitialController() as? StudentContentViewController else { fatalError() }
        vc.student = self
        return vc
    }
    
    
    public func toolbarConfigurator(toolbar: NSToolbar) {
        
        let items: [ToolbarItem] = [.Back, .FlexibleSpace, .Label, .FlexibleSpace, .Add, .Settings]
        toolbar.setItems(items)
        
        if let label = toolbar.viewForItemIdentifier(ToolbarItem.Label.identifier) as? NSTextField {
            label.stringValue = fullName
            label.invalidateIntrinsicContentSize()
        }
        
//        if let label = (toolbar.items.filter { $0.itemIdentifier == "ToolbarLabelItem" }).first?.view as? NSTextField {
//            label.stringValue = fullName
//        }
//        
//        if let button = (toolbar.items.filter { $0.itemIdentifier == "ToolbarButtonItem" }).first?.view as? NSButton {
//            button.image = NSImage(named: NSImageNameAddTemplate)
//            button.hidden = false
//        }
        
    }
    
}

