//
//  TableCellView.swift
//  SourceListKit
//
//  Created by Todd Olsen on 2/13/15.
//  Copyright (c) 2015 Todd Olsen. All rights reserved.
//

import Cocoa

public class TableCellView: NSTableCellView {

    public var showHiddenViews: Bool    = false
    
    var hidingViews: [NSView]           = []
    var trackingArea: NSTrackingArea?
    var mouseInside: Bool = false {
        didSet {
            let display: Bool = self.mouseInside // && self.selected;
            for view in hidingViews {
                view.hidden = !display;
            }
            self.needsDisplay = true
        }
    }
    
    override public func updateTrackingAreas() {
        super.updateTrackingAreas()
        ensureTrackingArea()
        if !trackingAreas.contains(trackingArea!) {
            addTrackingArea(trackingArea!)
        }
    }
    
    private func ensureTrackingArea() {
        if trackingArea == nil {
            trackingArea = NSTrackingArea(rect: NSZeroRect, options: [.InVisibleRect, .ActiveAlways, .MouseEnteredAndExited], owner: self, userInfo: nil)
        }
    }
 
    func updateDisplay() {
        let showViews: Bool = showHiddenViews && mouseInside
        for view in hidingViews {
            view.hidden = !showViews;
        }
        needsDisplay = true
    }
    
    override public func mouseEntered(theEvent: NSEvent) {
        mouseInside = true
        super.mouseEntered(theEvent)

    }
    
    override public func mouseExited(theEvent: NSEvent) {
        mouseInside = false
        super.mouseExited(theEvent)
    }
}
