//
//  AppKitExtensions.swift
//  Keystone-Mac
//
//  Created by Todd Olsen on 2/9/15.
//  Copyright (c) 2015 Todd Olsen. All rights reserved.
//

import Cocoa

struct RGBAConstituents {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
}

extension NSColor {
    
    public convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.startIndex.advancedBy(1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension NSView {
    
    func addFullSizeSubview(subview: NSView) {
        self.addSubview(subview)
        subview.addFullSizeConstraintsToSuperview()
    }
    
    func setFullSizeSubview(subview: NSView) { // Unsafe! what if view is nil?
        let edgeInsets = NSEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.setSubview(subview, edgeInsets: edgeInsets)
    }
    
    func setSubview(subview: NSView, edgeInsets: NSEdgeInsets) { // Unsafe! what if view is nil?
        
        self.subviews = [subview]
        subview.addConstraintsToSuperviewWithEdgeInsets(edgeInsets)
    }
    
    func addFullSizeConstraintsToSuperview() {
        
        addConstraintsToSuperviewWithEdgeInsets(NSEdgeInsetsMake(0.0, 0.0, 0.0, 0.0))
    }
    
    func addConstraintsToSuperviewWithEdgeInsets(edgeInsets: NSEdgeInsets) {
        
        let hFormat = "H:|-(\(edgeInsets.left))-[subview]-(\(edgeInsets.right))-|"
        let vFormat = "V:|-(\(edgeInsets.top))-[subview]-\((edgeInsets.bottom))-|"
        
        let hconstraints = NSLayoutConstraint.constraintsWithVisualFormat(hFormat, options: .AlignmentMask, metrics: nil, views: ["subview": self])
        let vconstraints = NSLayoutConstraint.constraintsWithVisualFormat(vFormat, options: .AlignmentMask, metrics: nil, views: ["subview": self])
        
        self.superview!.addConstraints(hconstraints)
        self.superview!.addConstraints(vconstraints)
    }
}

extension NSImage {
    
    public func imageWithTint(color: NSColor) -> NSImage {
        

        var imageRect = NSZeroRect
        imageRect.size = self.size
        let highlightImage = NSImage(size: imageRect.size)

        highlightImage.lockFocus()
        
        self.drawInRect(imageRect, fromRect: NSZeroRect, operation: .CompositeSourceOver, fraction: 1.0)
        color.set()
        NSRectFillUsingOperation(imageRect, .CompositeSourceAtop)
        
        highlightImage.unlockFocus()

        return highlightImage
    }
}

extension NSToolbar {
    
    func removeAllItems() {
        while self.items.count > 0 {
            self.removeItemAtIndex(0)
        }
    }
    
    func setItemsWithIdentifiers(identifiers: [String]) {
        self.removeAllItems()
        for identifier in Array(identifiers.reverse()) {
            self.insertItemWithItemIdentifier(identifier, atIndex: 0)
        }
    }
    
    func itemWithItemIdentifier(identifier: String) -> NSToolbarItem? {
        for item in self.items {
            if item.itemIdentifier == identifier {
                return item
            }
        }
        return nil
    }
    
    func viewWithItemIdentifier(identifier: String) -> NSView? {
        if let item = self.itemWithItemIdentifier(identifier) {
            if let view = item.view {
                return view
            }
        }
        return nil
    }
}