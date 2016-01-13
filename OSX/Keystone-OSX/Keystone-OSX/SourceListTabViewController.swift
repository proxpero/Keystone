//
//  SourceListTabViewController.swift
//  Example
//
//  Created by Todd Olsen on 11/18/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import SourceListKit
import Keystone_Model_OSX

public class SourceListTabViewController: NSTabViewController {
    
    public func selectItemType(itemType: SourceListItemType) -> () {
        
        switch itemType {
            
        case .DynamicChild(
            
                let sourceListConfigurator,
                let contentViewConfigurator,
                let toolbarConfigurator
            ):
            
            history.append((sourceListConfigurator, contentViewConfigurator, toolbarConfigurator))
            pushSourceListWithItems(sourceListConfigurator())
            pushContentViewController(contentViewConfigurator())
            if let toolbar = view.window?.toolbar { toolbarConfigurator(toolbar) }
            
        case .StaticChild(
                let identifier
            ):
            
            guard let vc = currentMainContentTabViewController as? StaticChildViewControllerType else { break }
            vc.selectTabItemWithIdentifier(identifier)
            
            
        case .StaticChildViewController(
                let identifier,
                let contentViewConfigurator
            ):
            
            guard let vc = currentMainContentTabViewController as? StaticChildViewControllerType else { break }
            let tvi = vc.selectTabItemWithIdentifier(identifier)
            if let tabVC = tvi?.viewController as? StaticChildViewControllerType {
                tabVC.newContentViewController(contentViewConfigurator())
            }
            
        default:break
            
        }
    }
    
    
    public func popSourceList(sender: NSButton) {
        guard history.count > 1 else { fatalError() }
        
        transitionOptions = TabTransitionType.Pop.options
        history.popLast()
        backButton.enabled = history.count > 1 ? true : false
        
        newSourceListWithItems(history.last!.sourceListConfigurator())
        popContentViewController(history.last!.contentViewConfigurator())
        
        if let toolbar = view.window?.toolbar {
            history.last!.toolbarConfigurator(toolbar)
        }
    }
    
    
//    public var managedObjectContext: NSManagedObjectContext!
    public var contentViewConfigurator: (NSViewController) -> () = { _ in }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

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
    
    // MARK: Private

    private typealias DynamicItem = (
        sourceListConfigurator: SourceListConfigurationHandler,
        contentViewConfigurator: ContentViewControllerConfigurationHandler,
        toolbarConfigurator: ToolbarConfigurationHandler
    )
    
    private var backButton: NSButton!
    private var history: [DynamicItem] = []
    private var currentMainContentTabViewController: NSTabViewController!
    
    private func newSourceListWithItems(sourceListItems: [SourceListItem]) {
        
        guard let vc = storyboard?.instantiateControllerWithIdentifier("SourceListViewController") as? SourceListViewController else { fatalError() }

        insertTabViewItem(NSTabViewItem(viewController: vc), atIndex: 0)
        selectedTabViewItemIndex = 0
    
        // root source list allows empty selection
        vc.sourceList.allowsEmptySelection = history.count == 1 ? true : false
        
        provider = SourceListConfigurationProvider(items: sourceListItems, sourceList: vc.sourceList)
        provider.selectionDidChangeHandler = selectItemType

    }
    
    private func pushSourceListWithItems(sourceListItems: [SourceListItem]) {
        
        transitionOptions = TabTransitionType.Push.options
        if let button = backButton {
            button.enabled = true
        }

        newSourceListWithItems(sourceListItems)
    }
    
    private func pushContentViewController(vc: NSViewController) {
        if let tabVC = vc as? NSTabViewController {
            currentMainContentTabViewController = tabVC
            tabVC.transitionOptions = TabTransitionType.Push.options
        }
        contentViewConfigurator(vc)
    }
    
    private func popContentViewController(vc: NSViewController) {
        if let tabVC = vc as? NSTabViewController {
            currentMainContentTabViewController = tabVC
            tabVC.transitionOptions = TabTransitionType.Pop.options
        }
        contentViewConfigurator(vc)
    }
    
    private var provider: SourceListConfigurationProvider!

}

public enum TabTransitionType {
    
    case Push
    case Pop
    
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
    
    private var options: NSViewControllerTransitionOptions {
        switch self {
        case .Push: return TabTransitionType.pushOptions
        case .Pop:  return TabTransitionType.popOptions
        }
    }
}
