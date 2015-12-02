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

extension AssignmentType {
    
    public var highlightColor: NSColor? {
        
        switch self {
        case .Overdue:      return SourceListKitConstants.Color.OverdueAssignment
        case .Active:       return SourceListKitConstants.Color.ActiveAssignment
        case .Completed:    return nil
        }
        
    }
    
    public var label: String {
        
        switch self {
        case .Overdue:      return "Overdue"
        case .Active:       return "Active"
        case .Completed:    return "Completed"
        }
        
    }
    
    public func headerCellWithAssignmentsCount(count: Int)(identifier: String)(tableView: NSTableView) -> SourceListHeaderCellView {
        
        guard let headerCell = tableView.makeViewWithIdentifier(identifier, owner: tableView) as? SourceListHeaderCellView else { fatalError() }
        
        let stringValue = "\(count) \(self.label) Assignment" + (count == 1 ? "" : "s")
        if let color = self.highlightColor {
            
            let mutableAttributedString = NSMutableAttributedString(
                string: stringValue,
                attributes: headerCell.textField?.attributedStringValue.attributesAtIndex(0, effectiveRange: nil))
            mutableAttributedString.addAttribute(NSForegroundColorAttributeName,
                value: color,
                range: (stringValue as NSString).rangeOfString(self.label))
            
            headerCell.textField?.attributedStringValue = mutableAttributedString
            
        } else {
            headerCell.textField?.stringValue = stringValue
        }
    
        return headerCell
    }
}

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
        
        return items
    }
}

extension Assignment: StaticChildViewControllerProvider {
    
    public func staticChildViewControllerSourceListItem() -> SourceListItem {
        return SourceListItem(
            itemType: staticChildViewControllerItemType(),
            cellViewConfigurator: cellViewConfigurator,
            cellSelectionCallback: cellSelectionCallback)
    }
}

extension Assignment {
    
    func staticChildViewControllerItemType() -> SourceListItemType {
        return .StaticChildViewController(
            identifier: StudentViewControllerItem.Assignments.rawValue,
            viewControllerConfigurator: contentViewControllerConfigurator)
    }

    func contentViewControllerConfigurator() -> NSViewController {
        guard let vc = NSStoryboard(name: "StudentContentView", bundle: NSBundle(forClass: AssignmentViewController.self)).instantiateControllerWithIdentifier("AssignmentViewController") as? AssignmentViewController else { fatalError() }
        vc.assignment = self
        return vc
    }
    
    func cellViewConfigurator(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier("SourceListAssignmentCellView", owner: tableView) as? SourceListAssignmentCellView else { fatalError() }
        view.textField?.stringValue = "\(name)"
        view.accessoryTextLabel.stringValue = "\(dueDateString().uppercaseString)"
        return view
    }
    
    func cellSelectionCallback() {
        print("Oh dear, an Assignment due on \(dueDateString()))")
    }
}

extension Assignment {
    
    static func cellViewConfigurator(assignment: Assignment)(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier("SourceListAssignmentCellView", owner: tableView) as? SourceListAssignmentCellView else { fatalError() }
        view.textField?.stringValue = "\(assignment.name)"
        view.accessoryTextLabel.stringValue = "\(assignment.dueDateString().uppercaseString)"
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
        print("Oh dear, an Assignment due on \(assignment.dueDateString()))")
    }
}


public final class SourceListAssignmentCellView: SourceListDetailCellView {
    
    @IBOutlet weak var accessoryTextLabel: NSTextField!
    
    
}