//
//  AssignmentContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/28/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public enum AssignmentViewControllerItem: String {
    // these names must correspond to contentTabViewController's tabViewItem identifiers as set in the storyboard
    case Details        = "Details"
    case Problems       = "Problems"
}

public protocol AssignmentSettable {
    var assignment: Assignment! { get set }
}

public final class AssignmentContentViewController: ContentTabViewController {
    
    public var assignment: Assignment! {
        didSet { title = String(assignment.dueDate) }
    }
    
    public override func tabView(tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, didSelectTabViewItem: tabViewItem)
        guard var vc = tabViewItem?.viewController as? AssignmentSettable else { return }
        vc.assignment = assignment
    }

}


public final class AssignmentDetailsViewController: NSViewController, AssignmentSettable {
    
    public var assignment: Assignment! {
        didSet {
            print("didSet")
            guard let name = nameField, let ao = assignedOnDatePicker, let due = dueDatePicker else { return }
            name.stringValue    = assignment.name
            ao.dateValue        = assignment.assignedOn
            due.dateValue       = assignment.dueDate
        }
    }
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var assignedOnDatePicker: NSDatePicker!
    @IBOutlet weak var dueDatePicker: NSDatePicker!
    
    @IBAction func assignedOnDateChangeAction(sender: NSDatePicker) { assignment.assignedOn = sender.dateValue }
    @IBAction func dueDateChangeAction(sender: NSDatePicker) { assignment.dueDate = sender.dateValue }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        print("vdl")
    }
    
    
}

public final class AssignmentProblemViewController: NSViewController, AssignmentSettable {
    
    public var assignment: Assignment!
    
}

//public final class AssignmentViewController: NSViewController {
//    
//    public var assignment: Assignment!
//    
//    deinit {
//        print("deinit assingmnet vc")
//    }
//}