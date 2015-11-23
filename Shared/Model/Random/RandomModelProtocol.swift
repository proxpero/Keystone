//
//  RandomModelProtocol.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/21/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

public protocol RandomModelObject {
    static func random() -> Self
}