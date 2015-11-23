//: Playground - noun: a place where people can play

import Cocoa
import MacUtilities
import Keystone_OSX_Model

func randomDate(isFuture isFuture: Bool) -> NSDate {
    return NSDate(timeIntervalSinceNow: (isFuture ? 1.0 : -1.0) * NSTimeInterval(60*60*24*7*3 * drand48()))
}

func randomDatesBeforeAndAfterDate(referenceDate: NSDate, weeksApart weeks: Double) -> (before: NSDate, after: NSDate) {
    let interval = NSTimeInterval(60*60*24*7*0.5*(1 + (drand48()/10))) * weeks
    let before = NSDate(timeInterval: -1.0 * interval, sinceDate: referenceDate)
    let after = NSDate(timeInterval: 1.0 * interval, sinceDate: referenceDate)
    return (before, after)
}

func randomDateNumberOfWeeksAgo(n: Double) -> NSDate {
    return NSDate(timeIntervalSinceNow: -1.0 * NSTimeInterval(60*60*24*7*n*(1+(drand48()/15))))
}

let week = NSTimeInterval(60*60*24*7)

let d = randomDateNumberOfWeeksAgo(14)
let x = randomDatesBeforeAndAfterDate(d, weeksApart: 2)

let p = Problem.random()

randomDate(isFuture: true)
randomDate(isFuture: false)

NSDate(timeIntervalSinceNow: (true ? 1.0 : -1.0) * NSTimeInterval(60*60*24*7*10 * drand48()))


let name = Person.randomFirstName() + " " + Person.randomLastName()
