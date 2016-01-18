//
//  UpdateTimestampable.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

let UpdateTimestampKey = "updatedAt"

protocol UpdateTimestampable {
    var updatedAt: NSDate { get set }
}
