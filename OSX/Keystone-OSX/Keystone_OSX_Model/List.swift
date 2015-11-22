//
//  List.swift
//  Example
//
//  Created by Todd Olsen on 11/18/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

public struct List {
    
    let name: String
    let problems: [Problem]
    init(name: String, problems: [Problem] = []) {
        self.name = name
        self.problems = problems
    }
}
