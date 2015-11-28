//
//  SourceListItemsProvider.swift
//  SourceListKit
//
//  Created by Todd Olsen on 11/19/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public protocol SourceListItemsProvider {
    static func sourceListItemsInContext(context: NSManagedObjectContext) -> [SourceListItem]
}