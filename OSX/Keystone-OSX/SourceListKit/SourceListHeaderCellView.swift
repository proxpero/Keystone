//
//  SourceListHeaderCellView.swift
//  SourceListKit
//
//  Created by Todd Olsen on 3/12/15.
//  Copyright (c) 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import UtilityKit_OSX

public class SourceListHeaderCellView: NSTableCellView {
    
    public var buttonActionCallback: ButtonConfigurationHandler?
    
    @IBOutlet var button: NSPopUpButton!
    @IBOutlet var horizontalLine: NSBox!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.horizontalLine.borderColor = NSColor.grayColor()
    }
    
    @IBAction func buttonAction(sender: AnyObject) {
        addHighlight()
        if let action = buttonActionCallback {
            action(button)
        }
    }
    
    private func addHighlight() {
        
        let highlightColor = SourceListKitConstants.Color.Highlight
        self.button.image = self.button.image?.imageWithTint(highlightColor)
        self.textField?.textColor = highlightColor
        self.horizontalLine.borderColor = highlightColor
        
        delay(0.3) {
            
            self.textField?.textColor = NSColor.secondaryLabelColor()
            self.horizontalLine.borderColor = NSColor.grayColor()
            self.button.image = self.button.image?.imageWithTint(NSColor.grayColor())

        }
    }
    
    var trackingArea: NSTrackingArea?
    var mouseInside: Bool = false {
        didSet {
//            updateDisplay()
            button.hidden = button.menu?.itemArray.count <= 1
            needsDisplay = true

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
    
//    func updateDisplay() {
//        
//        button.hidden = button.menu?.itemArray.count <= 1
//        needsDisplay = true
//    }
    
    override public func mouseEntered(theEvent: NSEvent) {
        mouseInside = true
        super.mouseEntered(theEvent)
        
    }
    
    override public func mouseExited(theEvent: NSEvent) {
        mouseInside = false
        super.mouseExited(theEvent)
    }

}