//
//  SourceListItemType.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/11/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import AppKit

public enum SourceListItemType {
    
    case Header // (pullDownConfigurator: HeaderPullDownMenuConfigurationHandler?)
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
