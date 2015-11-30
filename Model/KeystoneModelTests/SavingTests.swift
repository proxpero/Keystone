//
//  SavingTests.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/29/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import XCTest
@testable import KeystoneModel

class SavingTests: KeystoneModelTest {

    func testCreateStudentAndSave() {
        _ = Student.insertIntoContext(managedObjectContext)
        do {
            try managedObjectContext.save()
            print("Student saved successfully!")
        } catch {
            XCTFail()
        }
    }

    func testCreateAssignmentAndSave() {
        _ = Assignment.insertIntoContext(managedObjectContext)
        do {
            try managedObjectContext.save()
            print("Assignment saved successfully!")
        } catch {
            XCTFail()
        }
    }

    func testCreateProblemSetTemplateAndSave() {
        let template = ProblemSetTemplate.insertIntoContext(managedObjectContext)
        do {
            try managedObjectContext.save()
            print("Assignment Problem Set saved successfully!")
        } catch {
            XCTFail()
        }
        
        _ = ProblemSet.insertIntoContext(managedObjectContext, withTemplate: template)
        do {
            try managedObjectContext.save()
        } catch {
            XCTFail()
        }
    }
}
