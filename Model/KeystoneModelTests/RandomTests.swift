//
//  RandomTests.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import XCTest
import CoreData
@testable import KeystoneModel

class KeystoneModelRandomTests: KeystoneModelTest {

    func testRandomStudent() {
        let s1 = Student.randomInContext(managedObjectContext)
        print("student name: \(s1.fullName), graduation \(s1.graduationDate), assignments: \(s1.assignments)")
    }
}
