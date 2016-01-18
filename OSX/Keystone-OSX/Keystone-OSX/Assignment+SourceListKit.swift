//
//  Assignment+SourceListKit.swift
//  Keystone
//
//  Created by Todd Olsen on 11/28/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import SourceListKit
import Keystone_Model_OSX

extension Assignment: DynamicChildProvider { }


extension Assignment: DynamicSourceListItemProvider {

    public func dynamicCellViewConfigurator(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier("SourceListAssignmentCellView", owner: tableView) as? SourceListAssignmentCellView else { fatalError() }
        view.textField?.stringValue = "\(name)"
        view.accessoryTextLabel.stringValue = "\(dueDateString().uppercaseString)"
        return view
    }


    public func dynamicCellSelectionHandler() {
        print("Oh dear, an Assignment due on \(dueDateString()))")
    }

}


extension Assignment: DynamicChildItemTypeProvider {

    public func sourceListConfigurator() -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        items.append(defaultHeaderItemWithTitle("Summary"))
        items.append(defaultStaticDetailWithTabIdentifier(AssignmentViewControllerItem.Details.rawValue))
        
        items.append(defaultHeaderItemWithTitle("Problems"))
        if let problems = assignmentProblemSets.array as? [AssignmentProblemSet] {
            items.appendContentsOf(problems.map { $0.problemSet.staticChildViewControllerSourceListItem() })
        }
        
        return items
    }
    
    
    public func contentViewConfigurator() -> NSViewController {
        guard let vc = NSStoryboard(name: "AssignmentContentView", bundle: NSBundle(forClass: AssignmentContentViewController.self)).instantiateInitialController() as? AssignmentContentViewController else { fatalError() }
        vc.assignment = self
        return vc
    }
    
    public func toolbarConfigurator(toolbar: NSToolbar) {
        toolbar.setItems([.Back, .FlexibleSpace, .Label, .FlexibleSpace, .Add, .Share, .Settings])
        toolbar.setLabelText(name)
    }

}


public final class SourceListAssignmentCellView: SourceListDetailCellView {
    
    @IBOutlet weak var accessoryTextLabel: NSTextField!
    
}

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