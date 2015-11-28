//
//  ConstituentTransformerTests.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/25/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import XCTest
import CoreData
@testable import KeystoneModel

class ConstituentTransformerTests: KeystoneModelTest {

    func testDefaultStyle() {
        
        let defaultStyle = ConstituentStyle.defaultConstituentStyleInContext(managedObjectContext)
        XCTAssertNotNil(defaultStyle)

        let template = ProblemSetTemplate.insertIntoContext(managedObjectContext)
        var ps1: ProblemSet? = template.newProblemSet()
        let c1 = ps1!.addNewConstituentWithStyleIdentifier(defaultStyle.identifier)
        let text = NSAttributedString(string: "Some Text")
        c1.addConstituentItem(text)

        try! managedObjectContext.save()
        ps1 = nil
        
        
        let ps2 = ProblemSet.fetchInContext(managedObjectContext).first!
        XCTAssertNotNil(ps2)
//        XCTAssertEqual(ps1, ps2)
        
        XCTAssertTrue(ps2.constituents.first!.constituentItems.first!.isEqualToAttributedString(text))
        

        
        
        
//        let constituentItems: [ConstituentItem] = [
//            ConstituentItem(attributedString: NSAttributedString(string: "Hello World!")),
//            ConstituentItem(attributedString: NSAttributedString(string: "Why, hello to you!"))
//        ]
//
//        let c1 = Constituent(
//            styleIdentifier: "Test Constituent",
//            constituentItems: constituentItems)
        
        
        
    }

    
//    func testInitWithDict() {
//        
//        let dict = NSMutableDictionary()
//        
//        dict["inset"]   = NSNumber(float: 1.2)
//        dict["name"]    = "Constituent"
//        dict["marker"]  = NSNumber(integer: Marker.NumberWithDot.rawValue)
//        dict["items"]   = Array<NSData>()
//        
//        guard let c1 = Constituent(dict: dict) else { XCTFail(); fatalError() }
//        XCTAssertEqual(c1.name, "Constituent")
//        XCTAssertEqualWithAccuracy(c1.inset, CGFloat(1.2), accuracy: 0.0001)
//        XCTAssertEqual(c1.marker, Marker.NumberWithDot)
//        XCTAssertEqual(c1.constituentItems, [ConstituentItem]())
//    }
    
//    func testTransform() {
//        
//        let attrStr = NSAttributedString(string: "Hello!")
//        
//        let original = ProblemSet.insertIntoContext(managedObjectContext)
//        let constituent1 = original.addNewConstituentWithName("Constituent1")
//        let constituentItem1 = constituent1.addConstituentItemWithText(attrStr)
//        
//        XCTAssertTrue(original.constituents.first!.constituentItems.first!.text.isEqualToAttributedString(attrStr))
//        
//        try! managedObjectContext.save()
//        
//        let problemSet2 = ProblemSet.fetchInContext(managedObjectContext).first!
//        XCTAssertEqual(problemSet2.constituents.first!.name, "Constituent1")
//        XCTAssertEqual(problemSet2.constituents, original.constituents)
//        let c2 = problemSet2.constituents.first!
//        XCTAssertEqual(constituent1, c2)
//        let ci2 = c2.constituentItems.first!
//        XCTAssertEqual(constituentItem1, ci2)        
//    }
}
