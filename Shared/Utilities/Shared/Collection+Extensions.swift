//
//  Collection+Extensions.swift
//  TKOKit
//
//  Created by Todd Olsen on 8/13/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import Foundation

extension SequenceType where Generator.Element: Hashable {
    
    /// returns an array the unique elements
    func unique() -> [Generator.Element] {
        var seen: Set<Generator.Element> = []
        return self.filter {
            if seen.contains($0) {
                return false
            }
            else {
                seen.insert($0)
                return true
            }
        }
    }
    
    func frequencies() -> [(Generator.Element,Int)] {
        
        var frequency: [Generator.Element:Int] = [:]
        for x in self {
            frequency[x] = (frequency[x] ?? 0) + 1
        }
        
        return frequency.sort { $0.1 > $1.1 }
    }
}

extension CollectionType where Index == Int {
    
    /// Return a random element from `self`
    public func randomElement() -> Generator.Element? {
        guard startIndex != endIndex else { return nil } // Empty Collection
        if count == 1 { return self[0] }
        return self[Int(arc4random_uniform(UInt32(endIndex)))]
    }

    /// Return a copy of `self` with its elements shuffled
    public func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
    
    /// Return a random element from `self`
    public func random() -> Generator.Element? {
        if count == 0 { return nil }
        if count == 1 { return self[0] }
        
        return self[Int(arc4random_uniform(UInt32(count - 1)))]
    }

}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

extension Dictionary {
    mutating func merge<S: SequenceType where S.Generator.Element == (Key,Value)>(other: S) {
        for (k,v) in other {
            self[k] = v
        }
    }
}

extension Dictionary {
    init<S: SequenceType where S.Generator.Element == (Key,Value)>(_ sequence: S) {
        self = [:]
        self.merge(sequence)
    }
}

extension Dictionary {
    func mapValues<NewValue>(transform: Value -> NewValue) -> [Key:NewValue] {
        return Dictionary<Key, NewValue>(map { (key,value) in
            return (key, transform(value))
            }
        )
    }
}
