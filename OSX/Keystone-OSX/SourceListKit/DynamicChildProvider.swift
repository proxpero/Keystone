//
//  DynamicChildProvider.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/11/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

public protocol DynamicChildProvider: DynamicSourceListItemProvider {
    func dynamicSourceListItem() -> SourceListItem
}

extension DynamicChildProvider {
    
    public func dynamicSourceListItem() -> SourceListItem {
        return SourceListItem(
            itemType:                   dynamicChildItemType(),
            cellViewConfigurator:       dynamicCellViewConfigurator,
            cellSelectionCallback:      dynamicCellSelectionHandler
        )
    }
}