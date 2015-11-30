//
//  Constants.swift
//  GenericTableViewKit
//
//  Created by Todd Olsen on 11/21/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import UtilityKit_OSX

public struct SourceListKitConstants {
    
    public struct Color {
        public static let Highlight                 = NSColor(rgba: "#589FF5")
        public static let OffWhite                  = NSColor(rgba: "#F5F5F5")
        public static let OverdueAssignment         = NSColor(rgba: "#AC367F")
        public static let ActiveAssignment          = NSColor(rgba: "#A29C26")
        public static let CompletedAssignment       = NSColor(rgba: "#1B9C26")
    }
    
    public struct CellIdentifier {
        public static let Header = "SourceListHeaderCellView"
        public static let Detail = "SourceListDetailCellView"
    }
}

