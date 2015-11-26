//
//  Student+SourceListKit.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import Keystone_OSX_Model
import SourceListKit

extension Student: SourceListItemsProvider {
 
    public static var sourceListItems: [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        func configureHeaderCell(tableView: NSTableView) -> NSTableCellView {
            guard let headerCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Header, owner: tableView) as? SourceListHeaderCellView else { fatalError() }
            headerCell.textField?.stringValue = "Students"
            headerCell.showHiddenViews = true
            headerCell.buttonActionCallback = buttonAction
            return headerCell
        }
        
        func buttonAction(button: NSButton) {
            print("Student Header button clicked")
        }
        
        let header = SourceListItem(
            itemType: .Header,
            cellViewConfigurator: configureHeaderCell)
        
        items.append(header)
        
        let students: [Student] = []
        
        items.appendContentsOf(students.map { SourceListItem(
            itemType: .DynamicChild(
                sourceListConfigurator: Student.sourceListConfigurator($0),
                contentViewConfigurator: Student.contentViewControllerConfigurator($0),
                toolbarConfigurator: Student.toolbarConfigurator($0)),
            cellViewConfigurator: Student.cellViewConfigurator($0),
            cellSelectionCallback: Student.cellSelectionCallback($0)) })
        
        return items
        
    }
}

extension Student {
    static func cellViewConfigurator(student: Student)(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
        view.textField?.stringValue = student.fullName
        return view
    }

    static func contentViewControllerConfigurator(student: Student)() -> NSViewController {
        guard let vc = NSStoryboard(name: "StudentContentView", bundle: NSBundle(forClass: StudentContentViewController.self)).instantiateInitialController() as? StudentContentViewController else { fatalError() }
        vc.student = student
        return vc
    }
    
    static func sourceListConfigurator(student: Student)() -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        
        // Profile Header
        
        func configureProfileHeaderCell(tableView: NSTableView) -> NSTableCellView {
            guard let headerCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Header, owner: tableView) as? SourceListHeaderCellView else { fatalError() }
            headerCell.textField?.stringValue = "Profile"
            headerCell.showHiddenViews = false
            return headerCell
        }
        
        items.append(SourceListItem(
            itemType: .Header,
            cellViewConfigurator: configureProfileHeaderCell)
        )
        
        // Personal Item
        
        func personalCellViewConfigurator(tableView: NSTableView) -> NSTableCellView {
            guard let staticCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
            staticCell.textField?.stringValue = "Personal"
            staticCell.showHiddenViews = false
            return staticCell
        }
        
        func personalCellSelectionCallback() {
            print("Personal callback")
        }
        
        items.append(SourceListItem(
            itemType: .StaticChild(0),
            cellViewConfigurator: personalCellViewConfigurator,
            cellSelectionCallback: personalCellSelectionCallback)
        )
        
        // History Item
        
        func historyCellViewConfigurator(tableView: NSTableView) -> NSTableCellView {
            guard let staticCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
            staticCell.textField?.stringValue = "History"
            staticCell.showHiddenViews = false
            return staticCell
        }
        
        func historyCellSelectionCallback() {
            print("History callback")
        }
        
        items.append(SourceListItem(
            itemType: .StaticChild(1),
            cellViewConfigurator: historyCellViewConfigurator,
            cellSelectionCallback: historyCellSelectionCallback)
        )
        
        // Assignments: [Assignments]
        
        func configureAssignmentsHeaderCell(tableView: NSTableView) -> NSTableCellView {
            guard let headerCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Header, owner: tableView) as? SourceListHeaderCellView else { fatalError() }
            headerCell.textField?.stringValue = "Assignments"
            headerCell.showHiddenViews = true
            return headerCell
        }
        
        items.append(SourceListItem(
            itemType: .Header,
            cellViewConfigurator: configureAssignmentsHeaderCell))
        
        
        
        return items
    }

    static func toolbarConfigurator(student: Student)(toolbar: NSToolbar) {
        if let label = (toolbar.items.filter { $0.itemIdentifier == "ToolbarLabelItem" }).first?.view as? NSTextField {
            label.stringValue = student.fullName
        }
    }

    static func cellSelectionCallback(student: Student)() {
        print("Hi, I'm \(student.firstName)")
    }
}
