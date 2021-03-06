//
//  ProblemSetContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/3/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public final class ProblemSetContentViewController: NSSplitViewController, StaticChildViewControllerType {
    
    var tabViewController: ProblemSetViewController!
    var inspectorViewController: ProblemSetInspectorViewController!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tvc = splitViewItems.first?.viewController as? ProblemSetViewController else { fatalError() }
        guard let ivc = splitViewItems.last?.viewController as? ProblemSetInspectorViewController else { fatalError() }
        
        tabViewController = tvc
        inspectorViewController = ivc
        
        configureSplitView()
        
    }
    
    public func newContentViewController(viewController: NSViewController) {
        guard let tvc = splitViewItems.first?.viewController as? ProblemSetViewController else { fatalError() }
        guard let editor = viewController as? ProblemSetEditorViewController else { fatalError() }
        
        editor.inspector = inspectorViewController
        tvc.newContentViewController(viewController)
    }
    
    public func selectTabItemWithIdentifier(identifier: String) -> NSTabViewItem? {
        guard let tvc = splitViewItems.first?.viewController as? ProblemSetViewController else { fatalError() }
        
        return tvc.selectTabItemWithIdentifier(identifier)
    }
    
    private func configureSplitView() {
        guard splitViewItems.count == 2 else { fatalError() }
        guard let sourceListSplitViewItem = splitViewItems.last else { fatalError() }
        sourceListSplitViewItem.preferredThicknessFraction  = 0.18
        sourceListSplitViewItem.canCollapse                 = false
        sourceListSplitViewItem.maximumThickness            = 340
        sourceListSplitViewItem.minimumThickness            = 240
        sourceListSplitViewItem.holdingPriority             = NSLayoutPriorityDefaultLow + 10.0
        sourceListSplitViewItem.springLoaded                = true
    }

}

public final class ProblemSetViewController: ContentTabViewController { }

public final class ProblemSetEditorViewController: NSViewController {
    
    public weak var inspector: ProblemSetInspectorViewController!
    public var problemSet: ProblemSet! {
        didSet {
            title = "ps \(problemSet.problemItems.count)"
        }
    }

}

public final class ProblemSetInspectorViewController: NSViewController {
    
    public var problemSet: ProblemSet! {
        didSet {
            title = "ps \(problemSet.problemItems.count)"
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}