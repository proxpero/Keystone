//
//  List+Random.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 12/2/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData
import UtilityKit_OSX

extension List {
    
    public static func randomInContext(moc: NSManagedObjectContext, template: ListTemplate) -> List {
    
        let list = template.addNewListWithName(NSUUID().UUIDString.componentsSeparatedByString("-").first!)
        let problemSets = ProblemSet.fetchInContext(moc)
        let c = UInt32(problemSets.count)
        
        if let childrenTemplates = template.children?.array as? [ListTemplate] {
            
            for childTemplate in childrenTemplates {
                
                for _ in (1...5) {
                    _ = list.addNewChildListWithName(NSUUID().UUIDString.componentsSeparatedByString("-").first!, childTemplate: childTemplate)
                }

                if let grandchildrenTemplates = childTemplate.children?.array as? [ListTemplate] {
                    
                    for grandchildTemplate in grandchildrenTemplates {
                        
                        for childList in childTemplate.lists {
                            
                            let grandchildList = childList.addNewChildListWithName(NSUUID().UUIDString.componentsSeparatedByString("-").first!, childTemplate: grandchildTemplate)
                            
                            for _ in (1...5) {
                                grandchildList.addProblemSet(problemSets[Int(arc4random_uniform(c))])
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        return list
    }
    
    
}