//
//  KeystoneStack-OSX.swift
//  Keystone-OSX
//
//  Created by Todd Olsen on 11/23/15.
//  Copyright © 2015 Todd Olsen. All rights reserved.
//

import CoreData

private let StoreURL = NSURL.documentsURL.URLByAppendingPathComponent("Keystone.keystone")

public func createKeystoneMainContext(
    
    progress:               NSProgress?                     = nil,
    migrationCompletion:    NSManagedObjectContext -> ()    = { _ in })
    
        -> NSManagedObjectContext?
{
    wipeStoreIfNeeded(StoreURL)
    let version = KeystoneModelVersion(storeURL: StoreURL)
    guard version == nil || version == KeystoneModelVersion.CurrentVersion else {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            let context = NSManagedObjectContext(
                concurrencyType: .MainQueueConcurrencyType,
                modelVersion: KeystoneModelVersion.CurrentVersion, storeURL: StoreURL,
                progress: progress)
            dispatch_async(dispatch_get_main_queue()) {
                migrationCompletion(context)
            }
        }
        return nil
    }
    
    let context = NSManagedObjectContext(
        concurrencyType: .MainQueueConcurrencyType,
        modelVersion: KeystoneModelVersion.CurrentVersion, storeURL: StoreURL)
    context.mergePolicy = KeystoneMergePolicy(mode: .Local)
    
    return context
}


private func wipeStoreIfNeeded(url: NSURL)
{
    let newToken = NSFileManager.defaultManager().ubiquityIdentityToken
    let oldToken = NSUserDefaults.standardUserDefaults().ubiquityToken
    guard newToken?.isEqual(oldToken) == false || oldToken?.isEqual(newToken) == false else { return }
    
    NSUserDefaults.standardUserDefaults().ubiquityToken = newToken
    NSPersistentStoreCoordinator.destroyStoreAtURL(url)
}


private let UbiquityTokenKey = "com.proxpero.Keystone.UbiquityToken"


extension NSUserDefaults {
    private var ubiquityToken: NSObjectProtocol? {
        get {
            guard let string = stringForKey(UbiquityTokenKey),
                let data = NSData(base64EncodedString: string, options: NSDataBase64DecodingOptions())
                else { return nil }
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NSObjectProtocol
        }
        set {
            var string: String?
            if let token = newValue {
                string = NSKeyedArchiver.archivedDataWithRootObject(token).base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
            }
            setObject(string, forKey: UbiquityTokenKey)
        }
    }
}
