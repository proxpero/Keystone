//
//  Problem+Random.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/22/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

private func randomQuestion() -> String {
    var text = String(UnicodeScalar(Int(arc4random_uniform(26)) + 65))
    for _ in 1...Int(arc4random_uniform(100) + 150) {
        var n = 0
        switch Int(arc4random_uniform(3)) {
        case 1:     n = Int(arc4random_uniform(26)) + 97
        case 2:     n = Int(arc4random_uniform(26)) + 97
        default:    n = 32
        }
        text = text + String(UnicodeScalar(n))
        text = text.stringByReplacingOccurrencesOfString("  ", withString: " ")
    }
    return text + "?"
}

private func randomDifficulty() -> Double {
    return drand48() * 100.0
}

extension Problem: RandomModelObject {
    public static func random() -> Problem {
        return Problem(
            question: randomQuestion(),
            manualDifficulty: randomDifficulty())
    }
}

public let problems: [Problem] = {
   
    var problems = [Problem]()
    
    for _ in (0...1000) {
        problems.append(Problem.random())
    }
    
    return problems
    
}()
