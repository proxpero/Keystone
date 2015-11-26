//
//  TableRowView.swift
//  SourceListKit
//
//  Created by Todd Olsen on 2/13/15.
//  Copyright (c) 2015 Todd Olsen. All rights reserved.
//

import Cocoa

public class TableDataRowView: NSTableRowView {
    
    override public func drawSelectionInRect(dirtyRect: NSRect) {
        self.emphasized = false
        if self.selectionHighlightStyle != .None {
            
            var back = NSZeroRect
            var rem = NSZeroRect
            var highlight = NSZeroRect
            
            NSDivideRect(dirtyRect, &back, &rem, 14, NSRectEdge.MaxX)
            NSDivideRect(rem, &highlight, &rem, 7, NSRectEdge.MaxX)
            
            SourceListKitConstants.Color.Highlight.set()
            NSRectFill(highlight)
            
            NSColor.secondarySelectedControlColor().set()
            NSRectFill(rem)
        }
    }
}

public class TableHeaderRowView: NSTableRowView {

    override public func drawSelectionInRect(dirtyRect: NSRect) {
        self.emphasized = false
        if self.selectionHighlightStyle != .None {
            Swift.print("Start drawing")
        }
    }
}