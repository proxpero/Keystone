//
//  ProblemSet+SourceListKit.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/3/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import SourceListKit
import Keystone_Model_OSX

extension ProblemSet: StaticChildViewControllerProvider {

    public func staticChildViewControllerSourceListItem() -> SourceListItem {
        return SourceListItem(
            itemType:                   staticChildViewControllerItemType(),
            cellViewConfigurator:       cellViewConfigurator,
            cellSelectionCallback:      cellSelectionCallback)
    }
    
    func staticChildViewControllerItemType() -> SourceListItemType {
        return .StaticChildViewController(
            identifier:                 ListControllerItem.Problems.rawValue,
            viewControllerConfigurator: contentViewControllerConfigurator)
    }
    
    func contentViewControllerConfigurator() -> NSViewController {
        guard let vc = NSStoryboard(name: "ListContentView", bundle: NSBundle(forClass: ProblemSetViewController.self)).instantiateControllerWithIdentifier("ProblemSetViewController") as? ProblemSetViewController else { fatalError() }
        vc.problemSet = self
        return vc
    }
    
    func cellViewConfigurator(tableView: NSTableView) -> NSTableCellView {
        guard let view = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
        view.textField?.stringValue = "Problem"
        return view
    }
    
    func cellSelectionCallback() {
        print("Better solve this Problem Set!")
    }
    
}
