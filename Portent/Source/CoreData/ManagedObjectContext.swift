//
//  ManagedObjectContext.swift
//  Portent
//
//  Created by Flemming Pedersen on 07/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import CoreData
import Foundation

public class ManagedObjectContext: NSManagedObjectContext { }

public extension ManagedObjectContext {
    //MARK:
    public func insert<O: ManagedObject where O: ManagedObjectType>() -> O {
        guard let obj = NSEntityDescription.insertNewObjectForEntityForName(O.entityName, inManagedObjectContext: self) as? O else {
            fatalError("Wrong object type")
        }
        return obj
    }

    public func fetch<O: ManagedObject where O: ManagedObjectType>(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) throws -> [O] {
        let fetchRequest = NSFetchRequest(entityName: O.entityName)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors

        if let objects = try self.executeFetchRequest(fetchRequest) as? [O] {
            return objects
        }

        return []
    }
}

public extension ManagedObjectContext {
    //MARK: Save
    public func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    public func performChanges(block: () -> ()) {
        performBlock {
            block()
            self.saveOrRollback()
        }
    }
}

public enum StoreType: String {
    case Binary
    case InMemory
    case SQLite
}

public protocol ManagedObjectContextType {
    //MARK:
    static var modelURL: NSURL { get }
    static var storeURL: NSURL { get }
    static var modelObjectNameForValidation: String { get }
}

public extension ManagedObjectContextType {
    //MARK: Context
    static func privateContext() -> ManagedObjectContext {
        return context(concurrencyType: .PrivateQueueConcurrencyType)
    }

    static func mainContext() -> ManagedObjectContext {
        return context(concurrencyType: .MainQueueConcurrencyType)
    }

    static func context(storeType: StoreType = .SQLite, concurrencyType: NSManagedObjectContextConcurrencyType) -> ManagedObjectContext {
        guard let model = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Failed to create store model")
        }

        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        guard let _ = try? psc.addPersistentStoreWithType(storeType.rawValue, configuration: nil, URL: storeURL, options: nil) else {
            fatalError("Failed to add persistent store")
        }

        let context = ManagedObjectContext(concurrencyType: concurrencyType)
        context.persistentStoreCoordinator = psc
        return context
    }

    static func isValid(context: NSManagedObjectContext) -> Bool {
        guard let psc = context.persistentStoreCoordinator else {
            return false
        }
        return psc.managedObjectModel.entities.reduce(false) { return $0 || $1.managedObjectClassName == modelObjectNameForValidation }
    }
}
