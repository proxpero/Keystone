//
//  SourceListItem.swift
//  SourceListKit
//
//  Created by Todd Olsen on 11/19/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import AppKit

public typealias CellViewConfigurationHandler               = (NSTableView) -> NSTableCellView
public typealias ContentViewControllerConfigurationHandler  = () -> NSViewController
public typealias SourceListConfigurationHandler             = () -> [SourceListItem]
public typealias ToolbarConfigurationHandler                = (NSToolbar) -> ()
public typealias CellSelectionHandler                       = () -> ()
public typealias ButtonConfigurationHandler                 = (NSButton) -> ()
public typealias HeaderPullDownMenuConfigurationHandler     = (NSMenu) -> ()

public struct SourceListItem {
    
    public let itemType:                        SourceListItemType
    public let cellViewConfigurator:            CellViewConfigurationHandler
    public let cellSelectionCallback:           CellSelectionHandler?
    
    
    public init(
        itemType:                               SourceListItemType,
        cellViewConfigurator:                   CellViewConfigurationHandler,
        cellSelectionCallback:                  CellSelectionHandler? = nil)
    {
        self.itemType                           = itemType
        self.cellViewConfigurator               = cellViewConfigurator
        self.cellSelectionCallback              = cellSelectionCallback
    }

    func configuredCellForTableView(tableView: NSTableView) -> NSTableCellView? {
        return cellViewConfigurator(tableView)
    }
}


public protocol StaticChildViewControllerProvider {
    func staticChildViewControllerSourceListItem()    -> SourceListItem
}

public func defaultHeaderConfiguratorWithTitle(title: String, buttonAction: ButtonConfigurationHandler?) -> CellViewConfigurationHandler {
    
    func configureHeaderCell(tableView: NSTableView) -> NSTableCellView {
        
        guard let headerCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Header, owner: tableView) as? SourceListHeaderCellView else { fatalError() }
        headerCell.textField?.stringValue = title
        headerCell.buttonActionCallback = buttonAction
        
        return headerCell
    }
    
    return configureHeaderCell
}


public func defaultHeaderItemWithTitle(title: String, buttonActionHandler: ButtonConfigurationHandler? = nil) -> SourceListItem {
    
    return SourceListItem(
        itemType: .Header,
        cellViewConfigurator: defaultHeaderConfiguratorWithTitle(title, buttonAction: buttonActionHandler))
}

public func defaultStaticDetailConfiguratorWithTitle(title: String) -> CellViewConfigurationHandler {
    
    func configureStaticDetailCell(tableView: NSTableView) -> NSTableCellView {
        guard let staticCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Detail, owner: tableView) as? SourceListDetailCellView else { fatalError() }
        staticCell.textField?.stringValue = title
        return staticCell
    }
 
    return configureStaticDetailCell
}

public func defaultStaticDetailWithTabIdentifier(identifier: String, title: String? = nil, selectionHandler: CellSelectionHandler? = nil) -> SourceListItem {
    
    return SourceListItem(
        itemType: .StaticChild(identifier: identifier),
        cellViewConfigurator: defaultStaticDetailConfiguratorWithTitle(title == nil ? identifier : title!),
        cellSelectionCallback: selectionHandler)
}

