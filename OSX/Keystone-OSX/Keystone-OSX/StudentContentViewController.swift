//
//  StudentContentViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa
import Keystone_Model_OSX

public enum StudentViewControllerItem: String {
    case Personal       = "Personal"
    case History        = "History"
    case Assignments    = "Assignments"
}

private protocol StudentSettable {
    var student: Student! { get set }
}

public class StudentContentViewController: NSTabViewController, TabItemIdentifying {

    public var student: Student! {
        didSet {
            title = student.fullName
        }
    }

    public func selectTabItemWithIdentifier(identifier: String) -> NSTabViewItem? {
        if let
            tvi = (tabViewItems.filter { $0.identifier as? String == identifier }).first,
            index = tabViewItems.indexOf(tvi)
        {
            selectedTabViewItemIndex = index
            return tvi
        }
        return nil
    }
    
    public override func tabView(tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, didSelectTabViewItem: tabViewItem)
        guard var vc = tabViewItem?.viewController as? StudentSettable else { return }
        vc.student = student
    }
}

public class StudentPersonalProfileViewController: NSViewController, StudentSettable {
    
    public var student: Student! {
        didSet {
            
            guard let
                fn = firstNameTextField,
                ln = lastNameTextField,
                gr = graduationDatePicker,
                iv = imageView
            else { return }
            
            fn.stringValue  = student.firstName
            ln.stringValue  = student.lastName
            gr.dateValue    = student.graduationDate
            iv.image        = student.image == nil ? NSImage(named: NSImageNameUser) : NSImage(data: student.image!)
        }
    }
    
    @IBOutlet weak var firstNameTextField: NSTextField!
    @IBOutlet weak var lastNameTextField: NSTextField!
    @IBOutlet weak var graduationDatePicker: NSDatePicker!
    @IBOutlet weak var imageView: NSImageView!
    
    @IBAction func editButtonAction(sender: NSButton) {
        
        let isEditing: Bool = sender.state == NSOnState
        
        firstNameTextField.enabled = isEditing
        lastNameTextField.enabled = isEditing
        graduationDatePicker.datePickerStyle = isEditing ? .TextFieldAndStepperDatePickerStyle : .TextFieldDatePickerStyle
        graduationDatePicker.enabled = isEditing
        imageView.editable = isEditing
    }
    
    @IBAction func editFirstNameAction(sender: NSTextField) {
        student.firstName = sender.stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    @IBAction func editLastNameAction(sender: NSTextField) {
        student.lastName = sender.stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    @IBAction func editGraduationDateAction(sender: NSDatePicker) {
        student.graduationDate = sender.dateValue
    }
    
    @IBAction func editStudentImageAction(sender: NSImageView) {
        student.image = sender.image?.pngRepresentation()
    }
    
}

public class StudentHistoryViewController: NSViewController {
    
    public var student: Student!
    
}