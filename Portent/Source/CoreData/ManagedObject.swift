//
//  ManagedObject.swift
//  Portent
//
//  Created by Flemming Pedersen on 05/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import CoreData
import Foundation

public class ManagedObject: NSManagedObject { }

public protocol ManagedObjectType: class {
    //MARK:
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}

public extension ManagedObjectType {
    //MARK:
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
}
