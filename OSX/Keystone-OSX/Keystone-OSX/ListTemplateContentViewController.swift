//
//  ListTemplateContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/1/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX
import UtilityKit_OSX

public enum ListTemplateControllerItem: String {
    // these names must correspond to contentTabViewController's tabViewItem identifiers as set in the storyboard
    case Settings   = "Settings"
    case History    = "History"
}

private protocol ListTemplateSettable {
    var listTemplate: ListTemplate! { get set }
}

public final class ListTemplateContentViewController: ContentTabViewController {
    
    var listTemplate: ListTemplate!
    
    
    public override func tabView(tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, didSelectTabViewItem: tabViewItem)
        guard var vc = tabViewItem?.viewController as? ListTemplateSettable else { return }
        vc.listTemplate = listTemplate
    }
    
    deinit {
        print("deinit list template")
    }
}

public final class ListTemplateSettingsViewController: NSViewController, ListTemplateSettable {

    var listTemplate: ListTemplate!
    var listTemplateSettingsSubviewController: ListTemplateSettingsSubviewController!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        prepareStackView()
        guard let vc = storyboard?.instantiateControllerWithIdentifier("ListTemplateSettingsSubviewController") as? ListTemplateSettingsSubviewController else { fatalError() }
        stackView.addView(vc.view, inGravity: .Top)
    }

    @IBOutlet weak var scrollView: NSScrollView!

    private var constituentViewControllers = [ConstituentViewController]()
    private var stackView: NSStackView!
    private func prepareStackView() {
        stackView = NSStackView(frame: NSZeroRect)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .Vertical
        stackView.spacing = 1.0
        stackView.alignment = .Leading
        stackView.distribution = .Fill
        scrollView.documentView = stackView
        scrollView.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[document]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["document": stackView]))
    }
}

public final class ListTemplateSettingsSubviewController: NSViewController, ListTemplateSettable {
    
    var listTemplate: ListTemplate!
    
    @IBOutlet weak var header: ContentTextView!
    @IBOutlet weak var footer: ContentTextView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.whiteColor().CGColor

        
//        let inset = NSMakeSize(5, 5)
//        let font = NSFont.systemFontOfSize(15.0)
        
//        header.textContainerInset  = inset
//        header.font                = font
//        header.delegate            = self
//        header.configureView()
//        header.attributedString    = text
//        
//        markerLabel.font                    = font
//        markerLabel.textColor               = NSColor.lightGrayColor()
//        markerLabel.stringValue             = markerText
//        leadingInsetLength.constant         = insetLength
//        markerTopInsetConstraint.constant   = inset.height
        
        
        
        header.font = NSFont(name: "HelveticaNeue", size: 12.0)
        header.textContainerInset = NSMakeSize(5.0, 5.0)
        footer.font = NSFont(name: "HelveticaNeue", size: 12.0)
        footer.textContainerInset = NSMakeSize(5.0, 5.0)
        
    }
}
