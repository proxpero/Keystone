//
//  ProblemSetTemplate+Random.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/2/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData
import UtilityKit_OSX

extension ProblemSetTemplate {
    
    public static func randomInContext(moc: NSManagedObjectContext) -> ProblemSetTemplate {
        
        let name = NSUUID().UUIDString.componentsSeparatedByString("-").first!
        let template = ProblemSetTemplate.insertIntoContext(moc, name: name)
        
        for _ in (1...40) {
            
            let set = template.newProblemSet()
            _ = set.addNewProblemItem()
            _ = set.addNewProblemItem()
            
        }
        
        return template
    }
    
}