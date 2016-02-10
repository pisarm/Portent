//
//  Event.swift
//  Portent
//
//  Created by Flemming Pedersen on 05/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

public enum EventType: Int16 {
    case Trace
    case Debug
    case Info
    case Warn
    case Error
    case Fatal
}

public final class Event: ManagedObject {
    //MARK: Public
    @NSManaged public private(set) var created: NSDate
    @NSManaged public private(set) var fileName: String
    @NSManaged public private(set) var line: Int64
    @NSManaged public var message: String?
    @NSManaged public var payload: [String:AnyObject]?
    @NSManaged public private(set) var token: String
    public private(set) var eventType: EventType {
        get {
            guard let t = EventType(rawValue: type) else {
                fatalError("Unknown event type")
            }
            return t
        }
        set {
            type = newValue.rawValue
        }
    }

    //MARK: Private
    @NSManaged private var type: Int16
}

extension Event {
    //MARK:
    public static func insert(fileName fileName: String, line: Int64, token: String, context: ManagedObjectContext) -> Event {
        let event: Event = context.insert()
        event.created = NSDate()
        event.fileName = fileName
        event.line = line
        event.token = token
        return event
    }

    public static func fetch(context: ManagedObjectContext) throws -> [Event] {
        return try context.fetch(sortDescriptors: defaultSortDescriptors)
    }
}

extension Event: ManagedObjectType {
    //MARK: ManagedObjectType
    public static var entityName: String {
        return "Event"
    }

    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "created", ascending: true)]
    }
}
