//
//  Delay.swift
//  Keystone-Mac
//
//  Created by Todd Olsen on 4/3/15.
//  Copyright (c) 2015 Todd Olsen. All rights reserved.
//

import Foundation

public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}