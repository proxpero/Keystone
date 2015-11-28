//
//  RelationshipTests.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import XCTest
import CoreData
@testable import KeystoneModel

class KeystoneModelRelationshipTest: KeystoneModelTest {

    func testAddAssignmentToStudent() {
        
        let s1 = Student.insertIntoContext(managedObjectContext)
        let a1 = Assignment.insertIntoContext(managedObjectContext)
        
        XCTAssertNotNil(s1.assignments)
        XCTAssertEqual(s1.assignments.count, 0)
        
        let as1 = s1.mutableSetValueForKey("assignments")
        as1.addObject(a1)
        
        XCTAssertNotNil(s1.assignments)
        XCTAssertEqual(s1.assignments.count, 1)
        
        let s2 = Student.insertIntoContext(managedObjectContext)
        let a2 = Assignment.insertIntoContext(managedObjectContext)

        XCTAssertEqual(s2.assignments.count, 0)
        s2.addAssignment(a2)
        XCTAssertEqual(s2.assignments.count, 1)
        XCTAssertEqual(s2.assignments.first!, a2)
        
    }

    func testProblemSetAndProblemItemRelationship() {
        
        let template = ProblemSetTemplate.insertIntoContext(managedObjectContext)
        
        let ps1 = ProblemSet.insertIntoContext(managedObjectContext, withTemplate: template)
        ps1.addNewProblemItem()
        let pi1 = ps1.problemItems.objectAtIndex(0)
        XCTAssertNotNil(pi1)
        
        ps1.removeProblemItemAtIndex(0)
        XCTAssertEqual(ps1.problemItems.count, 1)
        
        ps1.addNewProblemItem()
        XCTAssertEqual(ps1.problemItems.count, 2)
        XCTAssertEqual(ps1.removeProblemItemAtIndex(0)!, pi1 as? ProblemItem)
        
        
    }
    
    func testAddAssignmentProblemToAssignment() {
        
    }
    
//    func testAddProblem
}
