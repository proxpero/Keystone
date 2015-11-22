//
//  Person.swift
//  Keystone-Mac
//
//  Created by Todd Olsen on 5/27/15.
//  Copyright (c) 2015 Todd Olsen. All rights reserved.
//

import Foundation

private func stringAtFile(file: String) -> String {
    
    let dirs = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true)
    
    do {
        let str = try String(contentsOfFile: dirs.first!.ns.stringByAppendingPathComponent(file), encoding: NSUTF8StringEncoding)
        return str
    } catch {
        return ""
    }
}

private func linesInString(string: String) -> [String] {
    var names = [String]()
    string.enumerateLines({ (line, stop) -> () in
        names.append(line)
    })
    return names
}

public class Person {
    private static let firstNames: [String] = linesInString(stringAtFile("Names/first-names.txt"))
    private static var lastNames: [String] = linesInString(stringAtFile("Names/last-names.txt"))

    public static func randomFirstName() -> String {
        return Person.firstNames.randomElement()!
    }
    
    public static func randomLastName() -> String {
        return Person.lastNames.randomElement()!
    }
}