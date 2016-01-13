//
//  SourceListItemsProvider.swift
//  SourceListKit
//
//  Created by Todd Olsen on 11/19/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import Keystone_Model_OSX

public protocol SourceListItemsProvider: ManagedObjectType {
    static func sourceListItemsInContext(context: NSManagedObjectContext) -> [SourceListItem]
}


public protocol SourceListHeaderTitleProvider: SourceListItemsProvider {
    static var headerTitle: String { get }
}


extension SourceListItemsProvider where
    Self: ManagedObjectType,
    Self: ManagedObject,
    Self: DynamicChildProvider
{
    public static func sourceListItemsInContext(context: NSManagedObjectContext) -> [SourceListItem] {
        
        var items: [SourceListItem] = []
        items.append(defaultHeaderItemWithTitle(Self.entityName))
        items.appendContentsOf(Self.sortedFetchInContext(context).map { $0.dynamicSourceListItem() })
        
        return items
    }
}


extension SourceListHeaderTitleProvider where Self: ManagedObjectType {
    static var headerTitle: String { return Self.entityName }
}

