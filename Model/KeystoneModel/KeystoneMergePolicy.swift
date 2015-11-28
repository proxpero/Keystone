//
//  KeystoneMergePolicy.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import CoreData


public class KeystoneMergePolicy: NSMergePolicy {
    public enum MergeMode {
        case Remote
        case Local
        
        private var mergeType: NSMergePolicyType {
            switch self {
            case .Remote: return .MergeByPropertyObjectTrumpMergePolicyType
            case .Local: return .MergeByPropertyStoreTrumpMergePolicyType
            }
        }
    }
    
    required public init(mode: MergeMode) {
        super.init(mergeType: mode.mergeType)
    }
    
    override public func resolveOptimisticLockingVersionConflicts(
        list: [NSMergeConflict]) throws
    {
        var regionsAndLatestDates: [(UpdateTimestampable, NSDate)] = []
        for (c, r) in list.conflictsAndObjectsWithType(UpdateTimestampable) {
            regionsAndLatestDates.append((r, c.newestUpdatedAt))
        }
        
        try super.resolveOptimisticLockingVersionConflicts(list)
        
        for (var region, date) in regionsAndLatestDates {
            region.updatedAt = date
        }
        
        resolveStudentConflicts(list)
//        resolveContinentConflicts(list)
    }
    
    func resolveStudentConflicts(conflicts: [NSMergeConflict]) {
//        for student in conflicts.objectsWithType(Student) {
//            student.refresh()
//            student.numberOfMoods = Int64(country.moods.count)
//        }
    }
    
//    func resolveContinentConflicts(conflicts: [NSMergeConflict]) {
//        for continent in conflicts.objectsWithType(Continent) {
//            continent.refresh()
//            continent.numberOfCountries = Int64(continent.countries.count)
//            guard let ctx = continent.managedObjectContext else { continue }
//            let count = Mood.countInContext(ctx) { request in
//                request.predicate = Mood.predicateWithFormat("country IN %@",
//                    args: continent.countries)
//            }
//            continent.numberOfMoods = Int64(count)
//        }
//    }
    
}


extension NSMergeConflict {
    var newestUpdatedAt: NSDate {
        guard let o = sourceObject as? UpdateTimestampable else {
            fatalError("must be UpdateTimestampable")
        }
        let key = UpdateTimestampKey
        let zeroDate = NSDate(timeIntervalSince1970: 0)
        let objectDate = objectSnapshot?[key] as? NSDate ?? zeroDate
        let cachedDate = cachedSnapshot?[key] as? NSDate ?? zeroDate
        let persistedDate = persistedSnapshot?[key] as? NSDate ?? zeroDate
        return max(o.updatedAt, max(objectDate,
            max(cachedDate, persistedDate)))
    }
}


extension SequenceType where Generator.Element == NSMergeConflict {
    func objectsWithType<T>(cls: T.Type) -> [T] {
        return map { $0.sourceObject }.filterByType()
    }
    
    func conflictsAndObjectsWithType<T>(cls: T.Type) -> [(NSMergeConflict, T)] {
        return filter { $0.sourceObject is T }.map { ($0, $0.sourceObject as! T) }
    }
}


extension NSDate: Comparable {}

public func ==(l: NSDate, r: NSDate) -> Bool {
    return l.timeIntervalSince1970 == r.timeIntervalSince1970
}

public func <(l: NSDate, r: NSDate) -> Bool {
    return l.timeIntervalSince1970 < r.timeIntervalSince1970
}

