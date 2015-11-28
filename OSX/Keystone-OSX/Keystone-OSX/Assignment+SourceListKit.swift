//
//  Assignment+SourceListKit.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/28/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import SourceListKit
import Keystone_Model_OSX

extension Assignment: SourceListItemsProvider {
    
    public static func sourceListItemsInContext(context: NSManagedObjectContext) -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        func configureHeaderCell(tableView: NSTableView) -> NSTableCellView {
            guard let headerCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Header, owner: tableView) as? SourceListHeaderCellView else { fatalError() }
            headerCell.textField?.stringValue = "Assignments"
            headerCell.showHiddenViews = true
            headerCell.buttonActionCallback = buttonAction
            return headerCell
        }
        
        func buttonAction(button: NSButton) {
            print("Assignment Header button clicked")
        }
        
        let header = SourceListItem(
            itemType: .Header,
            cellViewConfigurator: configureHeaderCell)
        
        items.append(header)
        
//        let assignments: [Assignment] = Assignment.fetchInContext(context)
        
//        items.appendContentsOf(assignments.map { SourceListItem(
//            itemType: .DynamicChild(
//                sourceListConfigurator: <#T##SourceListConfigurationHandler##SourceListConfigurationHandler##() -> [SourceListItem]#>,
//                contentViewConfigurator: <#T##ContentViewControllerConfigurationHandler##ContentViewControllerConfigurationHandler##() -> NSViewController#>,
//                toolbarConfigurator: <#T##ToolbarConfigurationHandler##ToolbarConfigurationHandler##(NSToolbar) -> ()#>),
//            cellViewConfigurator: <#T##CellViewConfigurationHandler##CellViewConfigurationHandler##(NSTableView) -> NSTableCellView#>,
//            cellSelectionCallback: <#T##CellSelectionHandler?##CellSelectionHandler?##() -> ()#>)
        
        return items
    }
}

extension Assignment {
    
    static func cellViewConfigurator(assignment: Assignment)(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
        view.textField?.stringValue = String(assignment.dueDate)
        return view
    }
    
    static func contentViewControllerConfigurator(assignment: Assignment)() -> NSViewController {
        guard let vc = NSStoryboard(name: "AssignmentContentView", bundle: NSBundle(forClass: AssignmentContentViewController.self)).instantiateInitialController() as? AssignmentContentViewController else { fatalError() }
        vc.assignment = assignment
        return vc
    }
    
    static func sourceListConfigurator(assignment: Assignment)() -> [SourceListItem] {
        return []
    }
    
    static func toolbarConfigurator(assignment: Assignment)(toolbar: NSToolbar) {
        if let label = (toolbar.items.filter { $0.itemIdentifier == "ToolbarLabelItem" }).first?.view as? NSTextField {
            label.stringValue = String(assignment.dueDate)
        }
    }
    
    static func cellSelectionCallback(assignment: Assignment)() {
        print("Oh dear, an Assignment due on \(String(assignment))")
    }
}
