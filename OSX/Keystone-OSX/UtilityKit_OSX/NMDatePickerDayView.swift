//
//  NMDatePickerDayView.swift
//
//  Created by Greg Kopel on 26.12.2014.
//  Copyright (c) 2014-15 Netmedia. All rights reserved.
//

import Cocoa


/**
* Custom view presenting single day in NMDatePickerView
*/
class NMDatePickerDayView: NSView {
    
    // MARK: - Public properties
    let dateComponents: NSDateComponents
    var backgroundColor: NSColor?
    var borderColor: NSColor?
    var selected: Bool?
    var highlighted: Bool?
    var highlightedBackgroundColor: NSColor?
    var highlightedBorderColor: NSColor?
    var selectedBackgroundColor: NSColor?
    var selectedBorderColor: NSColor?
    var todayBackgroundColor: NSColor?
    var todayBorderColor: NSColor?
    var textColor: NSColor? {
        didSet {
            self.label.textColor = textColor
        }
    }
    var selectedTextColor: NSColor?
    var highlightedTextColor: NSColor?
    var font: NSFont {
        didSet {
            self.label.font = font
            self.lineHeight = NMDatePicker.lineHeightForFont(self.font)
        }
    }
    
    // Callback actions
    var daySelectedAction: ((Void) -> (Void))?
    var dayHighlightedAction: ((Bool) -> (Void))?
    
    
    // MARK: - Private properties
    private var trackingArea: NSTrackingArea?
    private var label: NSTextField!
    private var lineHeight: CGFloat
    
    // MARK: - Initializers
    
    init(dateComponents: NSDateComponents) {
        self.dateComponents = dateComponents
        self.font = NSFont.systemFontOfSize(12.0)
        self.lineHeight = NMDatePicker.lineHeightForFont(self.font)
        super.init(frame: NSZeroRect)
        
        
        // Get day component
        let day = self.dateComponents.day
        
        // Configure label
        self.label = NSTextField(frame: NSZeroRect)
        self.label.editable = false
        self.label.backgroundColor = NSColor.clearColor()
        self.label.bordered = false
        self.label.alignment = NSTextAlignment.Center
        self.label.textColor = NSColor.blackColor()
        self.label.font = self.font
        self.label.stringValue = "\(day)"
        self.addSubview(self.label)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func resizeSubviewsWithOldSize(oldSize: NSSize) {
        let labelRect = CGRectMake(2.5, (self.bounds.size.height-self.lineHeight)/2+0.5, self.bounds.size.width-4, self.lineHeight)
        self.label.frame = CGRectIntegral(labelRect)
    }
    

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        var frameRect = CGRectInset(dirtyRect, 1, 1)
        frameRect.origin.x += 0.5
        frameRect.origin.y += 0.5
        let path = NSBezierPath(rect:frameRect)
        
        
        if self.selected == true {
            if let color = self.selectedBackgroundColor {
                color.setFill()
                path.fill()
            }
            if let color = self.selectedBorderColor {
                color.setStroke()
                path.stroke()
            }
        } else if self.highlighted == true {
            if let color = self.highlightedBackgroundColor {
                color.setFill()
                path.fill()
            }
            if let color = self.highlightedBorderColor {
                color.setStroke()
                path.stroke()
            }
        } else if NMDatePicker.isEqualDay(self.dateComponents, anotherDate: NSDate()) {
            if let color = self.todayBackgroundColor {
                color.setFill()
                path.fill()
            }
            if let color = self.todayBorderColor {
                color.setStroke()
                path.stroke()
            }
        } else {
            if let color = self.backgroundColor {
                color.setFill()
                path.fill()
            }
            if let color = self.borderColor {
                color.setStroke()
                path.stroke()
            }
        }
        
    }
    
    func setSelected(state: Bool) {
        self.selected = state
        if state == true {
            if let color = self.selectedTextColor {
                self.label.textColor = color
            }
            
        } else {
            if let color = self.textColor {
                self.label.textColor = color
            }
        }
        
        self.setNeedsDisplayInRect(self.bounds)
    }
    
    func setHighlighted(state: Bool) {
        self.highlighted = state
        self.setNeedsDisplayInRect(self.bounds)
    }
    
    // MARK: - Events handling
    
    override func mouseDown(theEvent: NSEvent) {
        if let action = self.daySelectedAction {
            action()
        }
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        if let action = self.dayHighlightedAction {
            action(true)
        }
    }
    
    override func mouseExited(theEvent: NSEvent) {
        if let action = self.dayHighlightedAction {
            action(false)
        }
    }
    
    override func updateTrackingAreas() {
        if self.trackingArea != nil {
            self.removeTrackingArea(self.trackingArea!)
        }
        let opts: NSTrackingAreaOptions = [NSTrackingAreaOptions.MouseEnteredAndExited, NSTrackingAreaOptions.ActiveAlways]
        self.trackingArea = NSTrackingArea(rect: self.bounds, options: opts, owner: self, userInfo: nil)
        self.addTrackingArea(self.trackingArea!)
        
    }
  
    
}
