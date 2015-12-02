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

extension Student: SourceListItemsProvider {
    
    public static func sourceListItemsInContext(context: NSManagedObjectContext) -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        items.append(defaultHeaderItemWithTitle("Student") { button in
            print("Student Head button clicked")
        })
        
        items.appendContentsOf(Student.fetchInContext(context).map { $0.dynamicSourceListItem() })
        
        return items
    }
}

extension Student: DynamicChildProvider {

    public func dynamicSourceListItem() -> SourceListItem {
        return SourceListItem(
            itemType:               dynamicChildItemType(),
            cellViewConfigurator:   dynamicCellViewConfigurator,
            cellSelectionCallback:  dynamicCellSelectionCallback)
    }
}

extension Student {
    
    func dynamicChildItemType() -> SourceListItemType {
        return .DynamicChild(
            sourceListConfigurator:  sourceListConfigurator,
            contentViewConfigurator: contentViewConfigurator,
            toolbarConfigurator:     toolbarConfigurator)
    }

    func sourceListConfigurator() -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        // Profile Header

        items.append(defaultHeaderItemWithTitle("Summary"))
        items.append(defaultStaticDetailWithIdentifier(StudentViewControllerItem.Profile.rawValue))
        items.append(defaultStaticDetailWithIdentifier(StudentViewControllerItem.History.rawValue))
        
        // Overdue Assignments
        
        let overdue = assignments.filter { $0.overdue }.sort { $0.dueDate.compare($1.dueDate) == .OrderedAscending }
        if overdue.count > 0 {
            
            items.append(SourceListItem(
                itemType: .Header,
                cellViewConfigurator: AssignmentType.Overdue.headerCellWithAssignmentsCount(overdue.count)(identifier: SourceListKitConstants.CellIdentifier.Header)))

            items.appendContentsOf(overdue.map { $0.staticChildViewControllerSourceListItem() })
        
        }

        // Active Assignments
        
        let active = assignments.filter { $0.active }.sort { $0.dueDate.compare($1.dueDate) == .OrderedAscending }
        if active.count > 0 {
            
            items.append(SourceListItem(
                itemType: .Header,
                cellViewConfigurator: AssignmentType.Active.headerCellWithAssignmentsCount(active.count)(identifier: SourceListKitConstants.CellIdentifier.Header)) {
                    print("Hey! I'm an active assignment")
                })
            
            items.appendContentsOf(active.map { $0.staticChildViewControllerSourceListItem() })
            
        }
        
        // Completed Assignments
        
        let completed = assignments.filter { $0.completed }.sort { $0.dueDate.compare($1.dueDate) == .OrderedDescending }
        if completed.count > 0 {
            
            items.append(SourceListItem(
                itemType: .Header,
                cellViewConfigurator: AssignmentType.Completed.headerCellWithAssignmentsCount(completed.count)(identifier: SourceListKitConstants.CellIdentifier.Header)) {
                    print("a completed assignemnt was selected!")
                })
            
            items.appendContentsOf(completed.map { $0.staticChildViewControllerSourceListItem() })
        }

        return items
    }
    
    func contentViewConfigurator() -> NSViewController {
        guard let vc = NSStoryboard(name: "StudentContentView", bundle: NSBundle(forClass: StudentContentViewController.self)).instantiateInitialController() as? StudentContentViewController else { fatalError() }
        vc.student = self
        return vc
    }
    
    func toolbarConfigurator(toolbar: NSToolbar) {
        if let label = (toolbar.items.filter { $0.itemIdentifier == "ToolbarLabelItem" }).first?.view as? NSTextField {
            label.stringValue = fullName
        }
    }
    
    func dynamicCellViewConfigurator(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
        view.textField?.stringValue = fullName
        return view
    }
    
    func dynamicCellSelectionCallback() {
        print("Hi, I'm \(fullName)")
    }
}

