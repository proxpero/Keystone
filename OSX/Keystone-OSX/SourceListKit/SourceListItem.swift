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
    case StaticChild(Int)
    
    var shouldSelect: Bool {
        switch self {
        case .Header:   return false
        default:        return true
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .Header:   return 44.0
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
