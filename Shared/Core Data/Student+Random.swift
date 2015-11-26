//
//  Student+Random.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import UtilityKit_OSX

extension Student { // random
    
    public static func randomStudentWtihContext(moc: NSManagedObjectContext) -> Student {
        
        let firstName   = Person.randomFirstName()
        let lastName    = Person.randomLastName()
        let graduationDate = NSDate.randomDate(yearsAgo: -15, offset: 1)
        
        let student = Student.insertIntoContext(moc,
            firstName: firstName,
            lastName: lastName,
            graduationDate: graduationDate)
        
        return student
    }    
}

