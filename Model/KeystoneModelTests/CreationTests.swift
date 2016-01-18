//
//  CreationTests.swift
//  KeystoneModelTests
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import XCTest
import CoreData
@testable import KeystoneModel

class KeystoneModelCreationTests: KeystoneModelTest {
    
    func testCreateStudent() {

        let s1 = Student.insertIntoContext(managedObjectContext)
        XCTAssertNotNil(s1)
        XCTAssertEqual(s1.firstName, "")
        XCTAssertEqual(s1.lastName, "")
        XCTAssertEqual(s1.graduationDate, NSDate(timeIntervalSince1970: 0))
        
        let firstName   = "Harry"
        let lastName    = "Potter"
        let date        = NSDate()
        
        let s2 = Student.insertIntoContext(managedObjectContext,
            firstName: firstName,
            lastName: lastName,
            graduationDate: date)

        XCTAssertNotNil(s2)
        XCTAssertEqual(s2.firstName, firstName)
        XCTAssertEqual(s2.lastName, lastName)
        XCTAssertEqual(s2.graduationDate, date)
        
        XCTAssertEqual(s2.fullName, "Harry Potter")
        
        let s3 = Student.insertIntoContext(managedObjectContext, firstName: "   Harry", lastName: "Potter\n", graduationDate: NSDate())
        XCTAssertEqual(s3.fullName, "Harry Potter")
    }
    
    
    
    func testCreateAssignment() {
        
        let a1 = Assignment.insertIntoContext(managedObjectContext)
        XCTAssertNotNil(a1)
        XCTAssertEqual(a1.assignedOn, NSDate(timeIntervalSince1970: 0))
        XCTAssertEqual(a1.dueDate, NSDate(timeIntervalSince1970: 1))
        XCTAssertNotNil(a1.note)
        
        let assignedOnDate  = NSDate(timeIntervalSinceNow: -60*60*24*7*3)
        let dueDate         = NSDate(timeInterval: 60*60*24, sinceDate: assignedOnDate)
        
        let a2 = Assignment.insertIntoContext(managedObjectContext,
            assignedOn: assignedOnDate, dueDate: dueDate)
        XCTAssertNotNil(a2)
        XCTAssertEqual(a2.assignedOn, assignedOnDate)
        XCTAssertEqual(a2.dueDate, dueDate)
        XCTAssertEqual(a2.note, "")
        
    }
    
    func testCreateProblemSet() {
     
        let template = ProblemSetTemplate.insertIntoContext(managedObjectContext)
        let ps1 = ProblemSet.insertIntoContext(managedObjectContext, withTemplate: template)
        
        XCTAssertNotNil(ps1)
        XCTAssertEqual(ps1.problemItems.count, 0)
        XCTAssertNotNil(ps1.constituents)
        
        let pi1 = ps1.addNewProblemItem()
        XCTAssertEqual(ps1.problemItems.count, 1)
        XCTAssertTrue(ps1.problemItems.containsObject(pi1))
        
        
        
    }

}
