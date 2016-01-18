//
//  KeystoneModelVersion.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import CoreData

enum KeystoneModelVersion: String {
    case Version1 = "Keystone_v1"
}

extension KeystoneModelVersion: ModelVersionType {
    static var AllVersions: [KeystoneModelVersion] { return [.Version1] }
    static var CurrentVersion: KeystoneModelVersion { return .Version1 }
    
    var name: String { return rawValue }
    var modelBundle: NSBundle { return NSBundle(forClass: Student.self) }
    var modelDirectoryName: String { return "Keystone_v1.momd" }
}

