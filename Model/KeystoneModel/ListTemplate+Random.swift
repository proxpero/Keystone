//
//  ListTemplate+Random.swift
//  Keystone
//
//  Created by Todd Olsen on 12/2/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation
import CoreData
import UtilityKit_OSX

extension ListTemplate {
    
    public static func randomInContext(moc: NSManagedObjectContext) -> ListTemplate {

        let name = NSUUID().UUIDString.componentsSeparatedByString("-").first!
        let listTemplate = ListTemplate.insertIntoContext(moc, title: name)

        for _ in (1...3) {

            let childTemplate = listTemplate.addNewChildWithTitle(NSUUID().UUIDString.componentsSeparatedByString("-").first!)
            
            for _ in (1...3) {
                _ = childTemplate.addNewChildWithTitle(NSUUID().UUIDString.componentsSeparatedByString("-").first!)
            }
        }
        
        return listTemplate        
    }
}