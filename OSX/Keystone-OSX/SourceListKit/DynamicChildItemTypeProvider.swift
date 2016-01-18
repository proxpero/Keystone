//
//  DynamicChildItemTypeProvider.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/11/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import AppKit

public protocol DynamicChildItemTypeProvider {
    
    func sourceListConfigurator() -> [SourceListItem]
    func contentViewConfigurator() -> NSViewController
    func toolbarConfigurator(toolbar: NSToolbar) -> ()
    
}

extension DynamicChildItemTypeProvider {
    
    public func toolbarConfigurator(toolbar: NSToolbar) {
        toolbar.setItems([.Back, .FlexibleSpace])
    }
    
}