//
//  DynamicSourceListItemProvider.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/11/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

public protocol DynamicSourceListItemProvider: DynamicChildItemTypeProvider {
    
    func dynamicChildItemType() -> SourceListItemType
    func dynamicCellViewConfigurator(tableView: NSTableView) -> NSTableCellView
    func dynamicCellSelectionHandler() -> ()
    
}


extension DynamicSourceListItemProvider {
    
    public func dynamicChildItemType() -> SourceListItemType {
        
        return .DynamicChild(
            sourceListConfigurator:     sourceListConfigurator,
            contentViewConfigurator:    contentViewConfigurator,
            toolbarConfigurator:        toolbarConfigurator
        )
    }
    
    public func dynamicCellSelectionHandler() -> () { }
    
}

extension DynamicSourceListItemProvider where Self: StaticDetailItemTitleProvider {
    
    public func dynamicCellViewConfigurator(tableView: NSTableView) -> NSTableCellView {
        guard let staticCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
        staticCell.textField?.stringValue = staticDetailItemTitle
        return staticCell
        
    }

}