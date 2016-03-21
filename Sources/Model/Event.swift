//
//  Event.swift
//  Portent
//
//  Created by Flemming Pedersen on 05/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

public enum EventType {
    case Trace
    case Debug
    case Info
    case Warn
    case Error
    case Fatal
    case Custom(name: String)
}

extension EventType: CustomStringConvertible {
    //MARK: CustomStringConvertible
    public var description: String {
        switch self {
        case Trace:
            return "TRACE"
        case Debug:
            return "DEBUG"
        case Info:
            return "INFO"
        case Warn:
            return "WARN"
        case Error:
            return "ERROR"
        case Fatal:
            return "FATAL"
        case let Custom(name):
            return name
        }
    }
}

extension EventType: Equatable {}
//MARK: Equatable
public func == (lhs: EventType, rhs: EventType) -> Bool {
    return lhs.description == rhs.description
}

public struct Event {
    let created: NSDate = NSDate()
    var fileName: String
    var line: Int
    var message: String?
    var payload: [String:AnyObject]?
    private(set) var type: String

    init(fileName: String, line: Int, message: String?, payload: [String:AnyObject]?, eventType: EventType) {
        self.fileName = fileName
        self.line = line
        self.message = message
        self.payload = payload
        self.type = eventType.description
    }
}
