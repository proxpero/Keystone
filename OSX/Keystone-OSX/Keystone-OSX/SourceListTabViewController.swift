//
//  SourceListTabViewController.swift
//  Example
//
//  Created by Todd Olsen on 11/18/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import SourceListKit

public class SourceListTabViewController: NSTabViewController {
    
    public var pushContentViewControllerHandler: (NSViewController) -> () = { _ in }
    
    private var backButton: NSButton!
    private var history: [(SourceListConfigurationHandler, ContentViewControllerConfigurationHandler, ToolbarConfigurationHandler)] = []
    private var currentTabViewController: NSTabViewController!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let root: SourceListItemType = {
           
            func rootSourceListConfigurator() -> [SourceListItem] {
                var items: [SourceListItem] = []
                items.appendContentsOf(Student.sourceListItems)
                items.appendContentsOf(List.sourceListItems)
                return items
            }
            
            func rootContentViewConfigurator() -> NSViewController {
                guard let vc = self.storyboard?.instantiateControllerWithIdentifier("DefaultTabViewController") as? NSTabViewController else { fatalError() }
                return vc
            }
            
            func rootToolbarConfigurator(toolbar: NSToolbar) {
                if let label = (toolbar.items.filter { $0.itemIdentifier == "ToolbarLabelItem" }).first?.view as? NSTextField {
                    label.stringValue = "Keystone"
                }
            }
            
            return SourceListItemType.DynamicChild(sourceListConfigurator: rootSourceListConfigurator, contentViewConfigurator: rootContentViewConfigurator, toolbarConfigurator: rootToolbarConfigurator)
        }()
        updateWithItemType(root)
    }
    
    public override func viewDidAppear() {
        if let
            toolbar = view.window?.toolbar,
            button = (toolbar.items.filter { $0.itemIdentifier == "ToolbarBackItem" }).first?.view as? NSButton
        {
            button.target = self
            button.action = Selector("popSourceList:")
            button.enabled = false
            backButton = button
        }
    }
    
    func updateSourceListWithItems(sourceListItems: [SourceListItem]) {
        if let vc = storyboard?.instantiateControllerWithIdentifier("SourceListViewController") as? SourceListViewController {

            insertTabViewItem(NSTabViewItem(viewController: vc), atIndex: 0)
            selectedTabViewItemIndex = 0
        
            vc.sourceList.allowsEmptySelection = history.count == 1 ? true : false
            
            provider = SourceListConfigurationProvider(items: sourceListItems, sourceList: vc.sourceList)
            provider.selectedItemTypeHandler = updateWithItemType
        }
    }
    
    func pushSourceListWithItems(sourceListItems: [SourceListItem]) {
        
        transitionOptions = TabTransitionType.Push.options
        if let button = backButton {
            button.enabled = true
        }

        updateSourceListWithItems(sourceListItems)
    }
    
    func popSourceList(sender: NSButton) {
        guard history.count > 1 else { fatalError() }
        
        transitionOptions = TabTransitionType.Pop.options
        history.popLast()
        backButton.enabled = history.count > 1 ? true : false
        updateSourceListWithItems(history.last!.0())
        popContentViewController(history.last!.1())
        if let toolbar = view.window?.toolbar {
            history.last!.2(toolbar)
        }
    }
    
    func pushContentViewController(vc: NSViewController) {
        if let tabVC = vc as? NSTabViewController {
            currentTabViewController = tabVC
            tabVC.transitionOptions = TabTransitionType.Push.options
        }
        pushContentViewControllerHandler(vc)
    }
    
    func popContentViewController(vc: NSViewController) {
        if let tabVC = vc as? NSTabViewController {
            currentTabViewController = tabVC
            tabVC.transitionOptions = TabTransitionType.Pop.options
        }
        pushContentViewControllerHandler(vc)
    }
    
    func updateWithItemType(itemType: SourceListItemType) -> () {

        switch itemType {

        case .DynamicChild(let sourceListConfigurator, let contentViewConfigurator, let toolbarConfigurator):
            
            history.append((sourceListConfigurator, contentViewConfigurator, toolbarConfigurator))
            pushSourceListWithItems(sourceListConfigurator())
            pushContentViewController(contentViewConfigurator())
            if let toolbar = view.window?.toolbar { toolbarConfigurator(toolbar) }

        case .StaticChild(let index):
            guard index < currentTabViewController.tabViewItems.count else { fatalError() }
            currentTabViewController.selectedTabViewItemIndex = index
            
        default:break
            
        }
    }

    // MARK: Private
    
    private var provider: SourceListConfigurationProvider!

}

public enum TabTransitionType {
    
    static private let pushOptions: NSViewControllerTransitionOptions = {
        var options = NSViewControllerTransitionOptions()
        options.unionInPlace(.AllowUserInteraction)
        options.unionInPlace(.Crossfade)
        options.unionInPlace(.SlideLeft)
        return options
        }()
    
    static private let popOptions: NSViewControllerTransitionOptions = {
        var options = NSViewControllerTransitionOptions()
        options.unionInPlace(.AllowUserInteraction)
        options.unionInPlace(.Crossfade)
        options.unionInPlace(.SlideRight)
        return options
        }()
    
    case Push
    case Pop
    
    private var options: NSViewControllerTransitionOptions {
        switch self {
        case .Push: return TabTransitionType.pushOptions
        case .Pop:  return TabTransitionType.popOptions
        }
    }
}