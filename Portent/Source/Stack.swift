//
//  Stack.swift
//  Portent
//
//  Created by Flemming Pedersen on 07/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

final class Stack {
    //MARK:
    static let modelName: String = "PortentModel.momd"
    static let storeName: String = "PortentStore.sqlite"
}

extension Stack: ManagedObjectContextType {
    //MARK: ManageObjectContextType
    static var modelURL: NSURL {
        let bundle = NSBundle(forClass: Stack.self)
        return bundle.URLForResource(modelName, withExtension: nil)!
    }

    static var storeURL: NSURL {
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!.URLByAppendingPathComponent(storeName)
    }

    static var modelObjectNameForValidation: String {
        return NSStringFromClass(Event.classForCoder())
    }
}
