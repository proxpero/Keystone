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

public enum SourceListItemType {
    case Header
    case DynamicChild(sourceListConfigurator: SourceListConfigurationHandler, contentViewConfigurator: ContentViewControllerConfigurationHandler, toolbarConfigurator: ToolbarConfigurationHandler)
    case StaticChild(identifier: String)
    case StaticChildViewController(identifier: String, viewControllerConfigurator: ContentViewControllerConfigurationHandler)
    
    var shouldSelect: Bool {
        switch self {
        case .Header:   return false
        default:        return true
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .Header:   return 40.0
        default:        return 22.0
        }
    }
    
    var rowView: NSTableRowView {
        switch self {
        case .Header:   return TableHeaderRowView()
        default:        return TableDataRowView()
        }
    }
}

public struct SourceListItem {
    
    public let itemType:                            SourceListItemType
    public let cellViewConfigurator:                CellViewConfigurationHandler
    public let cellSelectionCallback:               CellSelectionHandler?
    
    
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

public protocol DynamicChildProvider {
    
    func dynamicSourceListItem()        -> SourceListItem
//    func dynamicChildItemType()         -> SourceListItemType
//    func sourceListConfigurator()       -> SourceListConfigurationHandler
//    func contentViewConfigurator()      -> ContentViewControllerConfigurationHandler
//    func toolbarConfigurator()          -> ToolbarConfigurationHandler
//    func dynamicCellViewConfigurator()  -> CellViewConfigurationHandler
//    func dynamicCellSelectionCallback() -> CellSelectionHandler

}

public protocol StaticChildViewControllerProvider {
    func staticChildViewControllerSourceListItem()    -> SourceListItem
}

public func defaultHeaderConfiguratorWithTitle(title: String, buttonAction: ButtonConfigurationHandler?) -> CellViewConfigurationHandler {
    
    func configureHeaderCell(tableView: NSTableView) -> NSTableCellView {
        
        guard let headerCell = tableView.makeViewWithIdentifier(SourceListKitConstants.CellIdentifier.Header, owner: tableView) as? SourceListHeaderCellView else { fatalError() }
        headerCell.textField?.stringValue = title
        headerCell.showHiddenViews = true
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

public func defaultStaticDetailWithIdentifier(identifier: String, title: String? = nil, selectionHandler: CellSelectionHandler? = nil) -> SourceListItem {
    
    return SourceListItem(
        itemType: .StaticChild(identifier: identifier),
        cellViewConfigurator: defaultStaticDetailConfiguratorWithTitle(title == nil ? identifier : title!),
        cellSelectionCallback: selectionHandler)
}

