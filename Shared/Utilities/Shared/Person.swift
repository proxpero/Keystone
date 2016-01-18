//
//  Person.swift
//  Keystone-Mac
//
//  Created by Todd Olsen on 5/27/15.
//  Copyright (c) 2015 Todd Olsen. All rights reserved.
//

import Foundation

private func linesInString(string: String) -> [String] {
    var names = [String]()
    string.enumerateLines({ (line, stop) -> () in
        names.append(line)
    })
    return names
}

public class Person {
    private static let firstNames: [String] = linesInString(try! String(contentsOfURL: NSBundle(forClass: Person.self).URLForResource("first-names", withExtension: "txt")!))
    private static let lastNames: [String] = linesInString(try! String(contentsOfURL: NSBundle(forClass: Person.self).URLForResource("last-names", withExtension: "txt")!))

    public static func randomFirstName() -> String {
        return Person.firstNames.randomElement()!
    }
    
    public static func randomLastName() -> String {
        return Person.lastNames.randomElement()!
    }
}