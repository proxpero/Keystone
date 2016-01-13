//
//  DatePickerViewController.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/18/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Cocoa

public class DatePickerViewController: NSViewController, NMDatePickerDelegate {
    
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var datePicker: NMDatePicker!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let now = NSDate()
        updateDateLabel(now)
        
        self.datePicker.dateValue = now
        self.datePicker.delegate = self
        
        // NMDatePicker appearance properties
        datePicker.backgroundColor = NSColor.whiteColor()
        datePicker.font = NSFont.systemFontOfSize(13.0)
        datePicker.titleFont = NSFont.boldSystemFontOfSize(14.0)
        datePicker.textColor = NSColor.blackColor()
        datePicker.selectedTextColor = NSColor.whiteColor()
        datePicker.todayBackgroundColor = NSColor.whiteColor()
        datePicker.todayBorderColor = NSColor.blueColor()
        datePicker.highlightedBackgroundColor = NSColor.lightGrayColor()
        datePicker.highlightedBorderColor = NSColor.darkGrayColor()
        datePicker.selectedBackgroundColor = NSColor.orangeColor()
        datePicker.selectedBorderColor = NSColor.blueColor()
        
    }
    
    @IBAction func showTodayAction(sender: NSButton) {
        self.datePicker.displayViewForDate(NSDate())
    }
    
    func updateDateLabel(date: NSDate) {
        self.label.stringValue = "\(date)"
    }
    
    // MARK: - NMDatePicker delegate
    
    func nmDatePicker(datePicker: NMDatePicker, selectedDate: NSDate) {
        updateDateLabel(selectedDate)
    }

}
