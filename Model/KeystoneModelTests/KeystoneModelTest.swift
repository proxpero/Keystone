//
//  KeystoneModelTest.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/25/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import XCTest
import CoreData
@testable import KeystoneModel

class KeystoneModelTest: XCTestCase {
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        managedObjectContext = NSManagedObjectContext.keystoneInMemoryTestContext()        
    }
    
    override func tearDown() {
        managedObjectContext = nil
        super.tearDown()
    }
}