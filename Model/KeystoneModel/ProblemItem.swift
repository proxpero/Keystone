//
//  ProblemItem.swift
//  KeystoneModel
//
//  Created by Todd Olsen on 11/24/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData


extension ProblemItem {
    
    @NSManaged public private(set) var answer: String
    @NSManaged public private(set) var manualDifficulty: Double
    @NSManaged public private(set) var problemSet: ProblemSet
    @NSManaged public private(set) var assignmentProblemItems: Set<AssignmentProblemItem>
    @NSManaged public private(set) var tags: Set<Tag>?
    @NSManaged public private(set) var constituents: [Constituent]
    
}

extension ProblemItem {
    public var historicalDifficulty: Double {
        get {
            
            var correct:    Double  = 0.0
            var incorrect:  Double  = 0.0
            var omit:       Double  = 0.0
            
            for api in assignmentProblemItems {
                switch api.result {
                case .Correct:      correct++
                case .Incorrect:    incorrect++
                case .Omit:         omit++
                case .None:         break
                }
            }
            
            let sum = correct + incorrect + omit
            guard sum > 0 else { return 0 }
            
            let q = (correct - (0.25 * incorrect)) / sum
    
            return ceil((1 - q) * 100)
        }
    }
    
    public var compositeDifficulty: Double {
        get {
            let p: Double = 65.0 // priority as percentage favoring historical
            return ((100 - p) * manualDifficulty) + (p * historicalDifficulty)
        }
    }
    
}


extension ProblemItem {
    
    public static func insertIntoContext(moc: NSManagedObjectContext) -> ProblemItem {
        let problemItem: ProblemItem    = moc.insertObject()
        problemItem.answer              = ""
        problemItem.manualDifficulty    = 0.0
        return problemItem
    }
    
}