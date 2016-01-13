//
//  SourceListConfigurationProvider.swift
//  SourceListKit
//
//  Created by Todd Olsen on 11/17/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public final class SourceListConfigurationProvider {

    public init(
        items: [SourceListItem],
        sourceList: NSTableView? = nil)
    {
        self.items = items
        sourceList?.setDelegate(delegate)
        sourceList?.setDataSource(dataSource)
    }
    
    public var selectionDidChangeHandler: (SourceListItemType) -> () = { _ in }

    
    // Private:
    
    
    private var items: [SourceListItem]
    private var dataSource: NSTableViewDataSource { return bridgedDataSource }
    private var delegate: NSTableViewDelegate { return bridgedDelegate }
    
    private func tableViewSelectionDidChange(tableView: NSTableView) {
        guard tableView.selectedRow != -1 else { return }
        selectionDidChangeHandler(items[tableView.selectedRow].itemType)
        if let callback = items[tableView.selectedRow].cellSelectionCallback { callback() }
    }
    
    private lazy var bridgedDataSource: BridgedSourceListDataSource = BridgedSourceListDataSource(
        numberOfRowsInTableView: { [unowned self] () -> Int in
            return self.items.count
        }
    )
    
    private lazy var bridgedDelegate: BridgedSourceListDelegate = BridgedSourceListDelegate(
        viewForRow: { [unowned self] (tableView, row) -> NSView? in
            return self.items[row].configuredCellForTableView(tableView)
        },
        tableViewShouldSelectRow: { [unowned self] (tableView, row) -> Bool in
            return self.items[row].itemType.shouldSelect
        },
        tableViewHeightOfRow: { [unowned self] (tableView, row) -> CGFloat in
            return self.items[row].itemType.rowHeight
        },
        tableViewSelectionDidChange: { [unowned self] (notification) -> () in
            guard let tableView = notification.object as? NSTableView else { fatalError() }
            self.tableViewSelectionDidChange(tableView)
        },
        tableViewRowViewForRow: { [unowned self] (tableView, row) -> NSTableRowView? in
            self.items[row].itemType.rowView
        }
    )
}

@objc private final class BridgedSourceListDataSource: NSObject, NSTableViewDataSource {
    
    typealias NumberOfRowsInTableViewHandler = () -> Int
    
    let numberOfRows: NumberOfRowsInTableViewHandler
    
    init(numberOfRowsInTableView: NumberOfRowsInTableViewHandler) {
        self.numberOfRows = numberOfRowsInTableView
    }

    @objc private func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return numberOfRows()
    }
}

@objc private final class BridgedSourceListDelegate: NSObject, NSTableViewDelegate {
    
    typealias ViewForRowHandler = (NSTableView, Int) -> NSView?
    typealias ShouldSelectRowHandler = (NSTableView, Int) -> Bool
    typealias HeightOfRowHandler = (NSTableView, Int) -> CGFloat
    typealias SelectionDidChangeHandler = (NSNotification) -> ()
    typealias RowViewForRowHandler = (NSTableView, Int) -> NSTableRowView?
    
    let viewForRow: ViewForRowHandler
    let shouldSelectRow: ShouldSelectRowHandler
    let heightOfRow: HeightOfRowHandler
    let selectionDidChange: SelectionDidChangeHandler
    let rowViewForRow: RowViewForRowHandler
    
    init(viewForRow: ViewForRowHandler, tableViewShouldSelectRow: ShouldSelectRowHandler, tableViewHeightOfRow: HeightOfRowHandler, tableViewSelectionDidChange: SelectionDidChangeHandler, tableViewRowViewForRow: RowViewForRowHandler) {
        self.viewForRow = viewForRow
        self.shouldSelectRow = tableViewShouldSelectRow
        self.heightOfRow = tableViewHeightOfRow
        self.selectionDidChange = tableViewSelectionDidChange
        self.rowViewForRow = tableViewRowViewForRow
    }
    
    @objc private func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return viewForRow(tableView, row)
    }
    
    @objc private func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return shouldSelectRow(tableView, row)
    }
    
    @objc private func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return heightOfRow(tableView, row)
    }
    
    @objc private func tableViewSelectionDidChange(notification: NSNotification) {
        selectionDidChange(notification)
    }
    
    @objc private func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return rowViewForRow(tableView, row)
    }
}