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
    
    public func pngRepresentation() -> NSData? {
        
        self.lockFocus()
        let bitmapRep = NSBitmapImageRep(focusedViewRect: NSMakeRect(0, 0, self.size.width, self.size.height))
        self.unlockFocus()
        
        return bitmapRep?.representationUsingType(.NSPNGFileType, properties: [:])
    }
}


class FlippedClipView: NSClipView {
    override var flipped: Bool { return true }
}

public class ResizingTextView: NSView, NSTextViewDelegate {
    
    public weak var delegate: NSTextViewDelegate?
    
    public var textContainerInset: NSSize {
        get { return textView.textContainerInset }
        set { textView.textContainerInset = newValue; resizeTextView() }
    }
    
    
    public var font: NSFont? {
        get { return textView.font }
        set { textView.font = newValue; resizeTextView() }
    }
    
    
    public var alignment: NSTextAlignment {
        get { return textView.alignment }
        set { textView.alignment = newValue }
    }
    
    public var backgroundColor: NSColor {
        get { return textView.backgroundColor }
        set { textView.backgroundColor = newValue }
    }
    
    public var string: String? {
        get { return textView.string }
        set { textView.string = newValue; resizeTextView() }
    }
    
    
    public var attributedString: NSAttributedString {
        get { return textView.attributedString() }
        set { textView.textStorage?.setAttributedString(newValue); resizeTextView() }
    }
    
    
    public var selectedRange: NSRange {
        get { return textView.selectedRange() }
        set { textView.setSelectedRange(newValue) }
    }
    
    
    public var editable: Bool {
        get { return textView.editable }
        set { textView.editable = newValue }
    }
    
    
    public var selectable: Bool {
        get { return textView.selectable }
        set { textView.selectable = newValue }
    }
    
    
    func addAttribute(name: String, value: AnyObject, range: NSRange) {
        textView.textStorage?.addAttribute(name, value: value, range: range)
    }
    
    // MARK: NSTextDelegate
    
    public func textShouldBeginEditing(textObject: NSText) -> Bool {
        if let f = delegate?.textShouldBeginEditing { return f(textObject) } else { return true }
    }
    
    public func textDidBeginEditing(notification: NSNotification) {
        if let f = delegate?.textDidBeginEditing { f(notification) }
    }
    
    public func textDidChange(notification: NSNotification) {
        if let f = delegate?.textDidChange { f(notification) }
        resizeTextView()
    }
    
    public func textShouldEndEditing(textObject: NSText) -> Bool {
        if let f = delegate?.textShouldEndEditing { return f(textObject) } else { return true }
    }
    
    public func textDidEndEditing(notification: NSNotification) {
        if let f = delegate?.textDidEndEditing { f(notification) }
    }
    
    // MARK: NSTextViewDelegate
    
    public func textView(textView: NSTextView, willChangeSelectionFromCharacterRange oldSelectedCharRange: NSRange, toCharacterRange newSelectedCharRange: NSRange) -> NSRange {
        // Unimplemented
        return newSelectedCharRange
    }
    
    public func textView(textView: NSTextView, willChangeSelectionFromCharacterRanges oldSelectedCharRanges: [NSValue], toCharacterRanges newSelectedCharRanges: [NSValue]) -> [NSValue] {
        // Unimplemented
        return newSelectedCharRanges
    }
    
    public func textViewDidChangeSelection(notification: NSNotification) {
        if let f = delegate?.textViewDidChangeSelection {
            f(notification)
        }
    }
    
    public func textViewDidChangeTypingAttributes(notification: NSNotification) {
        if let f = delegate?.textViewDidChangeTypingAttributes {
            f(notification)
        }
    }
    
    // MARK: Initialization
    
    private var heightConstraint: NSLayoutConstraint!
    internal var textView: RespondingTextView!
    
    convenience init() {
        self.init(frame: NSZeroRect)
        //        configure()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configure()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textView = RespondingTextView(frame: NSZeroRect)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        
        textView.richText = true
        textView.editable = true
        textView.allowsUndo = true
        textView.importsGraphics = true
        textView.automaticDashSubstitutionEnabled = true
        textView.automaticQuoteSubstitutionEnabled = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textViewFrameDidChange:", name: NSViewFrameDidChangeNotification, object: textView)
        
        self.addSubview(textView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[textView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["textView": textView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[textView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["textView": textView]))
        
        heightConstraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0.0)
        self.addConstraint(heightConstraint)
        resizeTextView()
    }
    
    // MARK: External Sizing
    
    func textViewFrameDidChange(notification: NSNotification) {
        if let tv = notification.object as? NSTextView where tv == textView {
            resizeTextView()
        }
    }
    
    func resizeTextView() {
        let horizontalPadding = 2.0 * textView.textContainerInset.width
        let verticalPadding = 2.0 * textView.textContainerInset.height
        
        var height: CGFloat = 0.0
        if textView.string == nil || textView.string!.isEmpty {
            height = singleLineHeight() + verticalPadding
        } else {
            height = (textView.attributedString().heightForWidth(textView.bounds.size.width - horizontalPadding)) + verticalPadding
        }
        heightConstraint.constant = height
    }
    
    private func singleLineHeight() -> CGFloat {
        return "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz12345667890".heightForWidth(CGFloat.max, font: textView.font!)
    }
}


protocol ResponderObservable {
    typealias Event
    mutating func registerForBecomingResponder(observer: Event -> ())
    mutating func registerForResigningResponder(observer: Event -> ())
}


public class ContentTextView: ResizingTextView {
    typealias Event = RespondingTextView
    
    func configureView() {
        wantsLayer = true
        layer?.cornerRadius = 3.0
        layer?.borderColor = defaultBorderColor.CGColor
        layer?.borderWidth = 1.0
        
        textView.registerForBecomingResponder(textViewDidBecomeKeyView)
        textView.registerForResigningResponder(textViewDidResignKeyView)
    }
    
    let highlightBorderColor    = NSColor(calibratedRed: 151.0/255.0, green: 197.0/255.0, blue: 246.0/255.0, alpha: 1.0)
    let defaultBorderColor      = NSColor(calibratedWhite: 197.0/255.0, alpha: 1.0)
    
    func textViewDidBecomeKeyView(textView: RespondingTextView) {
        layer?.borderColor = highlightBorderColor.CGColor
        layer?.borderWidth = 2.0
    }
    
    func textViewDidResignKeyView(textView: RespondingTextView) {
        layer?.borderColor = defaultBorderColor.CGColor
        layer?.borderWidth = 1.0
    }
    
    var textViewWantsToAdvance: (RespondingTextView) -> () = { tv in }
    var textViewWantsToRegress: (RespondingTextView) -> () = { tv in }
}


public class RespondingTextView: NSTextView, ResponderObservable {
    
    typealias Event = RespondingTextView
    
    var becomingResponderObservers: [RespondingTextView -> ()] = []
    var resigningResponderOberservers: [RespondingTextView -> ()] = []
    
    func registerForBecomingResponder(observer: RespondingTextView -> ()) { becomingResponderObservers.append(observer) }
    func registerForResigningResponder(observer: RespondingTextView -> ()) { resigningResponderOberservers.append(observer) }
    
    override public func becomeFirstResponder() -> Bool {
        guard super.becomeFirstResponder() else { return false }
        for observer in becomingResponderObservers {
            observer(self)
        }
        return true
    }
    
    override public func resignFirstResponder() -> Bool {
        guard super.resignFirstResponder() else { return false }
        for observer in resigningResponderOberservers {
            observer(self)
        }
        return true
    }
    
    let returnKey   = 36
    let tabKey      = 48
    let upKey       = 126
    let downKey     = 125
    let leftKey     = 123
    let rightKey    = 124
    let deleteKey   = 51
    
    override public func keyDown(theEvent: NSEvent) {
        
        let isAtLeadingEdge     = NSEqualRanges(selectedRange(), NSMakeRange(0, 0))
        let isAtTrailingEdge    = NSEqualRanges(selectedRange(), NSMakeRange((string?.characters.count)!, 0))
        
        switch (theEvent.keyCode, isAtLeadingEdge, isAtTrailingEdge) {
        case (126, true, _):    // UP
            window?.selectPreviousKeyView(self)
        case (125, _, true):    // DOWN
            window?.selectNextKeyView(self)
        case (123, true, _):    // LEFT
            window?.selectPreviousKeyView(self)
        case (124, _, true):    // RIGHT
            window?.selectNextKeyView(self)
        case (51, true, _):
            Swift.print("delete")
        default:
            super.keyDown(theEvent)
        }
    }
    
}


public enum ToolbarItem {
    
    case Back
    case Label
    case Share
    case Settings
    case Add
    
    case FlexibleSpace
    case Space
    
    public var identifier: String {
        
        switch self {
        case .Back:             return "ToolbarBackItem"
        case .Label:            return "ToolbarLabelItem"
        case .Share:            return "ToolbarShareItem"
        case .Settings:         return "ToolbarSettingsItem"
        case .Add:              return "ToolbarAddItem"
        case .FlexibleSpace:    return NSToolbarFlexibleSpaceItemIdentifier
        case .Space:            return NSToolbarSpaceItemIdentifier
        }
    }
    
}


extension NSToolbar {
    
    public func removeAllItems() {
        for _ in items {
            removeItemAtIndex(0)
        }
    }
    
    public func setItems(items: [ToolbarItem]) {
        removeAllItems()
        for item in items.reverse() {
            insertItemWithItemIdentifier(item.identifier, atIndex: 0)
        }
    }
    
    public func itemWithIdentifer(identifier: String) -> NSToolbarItem? {
        for item in items as [NSToolbarItem] {
            if item.itemIdentifier == identifier { return item }
        }
        return nil
    }
    
    public func viewForItemIdentifier(identifier: String) -> NSView? {
        if let
            item = itemWithIdentifer(identifier),
            view = item.view
        {
            return view
        }
        return nil
    }
    
    public func setLabelText(text: String) {
        if let label = viewForItemIdentifier(ToolbarItem.Label.identifier) as? NSTextField {
            label.stringValue = text
        }
    }
}