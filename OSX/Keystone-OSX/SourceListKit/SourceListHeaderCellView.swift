//
//  SourceListHeaderCellView.swift
//  SourceListKit
//
//  Created by Todd Olsen on 3/12/15.
//  Copyright (c) 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import UtilityKit_OSX

public class SourceListHeaderCellView: TableCellView {
    
    public var buttonActionCallback: (NSButton) -> ()   = { button in }
    
    @IBOutlet var button: NSButton!
    @IBOutlet var horizontalLine: NSBox!
    
    override public func awakeFromNib() {
        super.awakeFromNib()

        hidingViews = [button]
        self.horizontalLine.borderColor = NSColor.grayColor()
    }
    
    @IBAction func buttonAction(sender: AnyObject) {
        addHighlight()
        buttonActionCallback(button)
    }
    
    private func addHighlight() {
        
        let highlightColor = SourceListKitConstants.Color.Highlight
        self.button.image = self.button.image?.imageWithTint(highlightColor)
        self.textField?.textColor = highlightColor
        self.horizontalLine.borderColor = highlightColor
        self.hidingViews = []
        
        delay(0.3) {
            
            self.textField?.textColor = NSColor.secondaryLabelColor()
            self.horizontalLine.borderColor = NSColor.grayColor()
            self.button.image = self.button.image?.imageWithTint(NSColor.grayColor())
            self.button.state = 0
            self.hidingViews = [self.button]
        }
    } 
}