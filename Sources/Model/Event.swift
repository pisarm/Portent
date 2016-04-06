//
//  Event.swift
//  Portent
//
//  Created by Flemming Pedersen on 05/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

public enum EventLevel {
    case Custom(key: String)
    case Debug
    case Error
    case Info
    case Trace
    case Warn
}

extension EventLevel: CustomStringConvertible {
    //MARK: CustomStringConvertible
    public var description: String {
        switch self {
        case let Custom(key):
            return key
        case Debug:
            return "DEBUG"
        case Error:
            return "ERROR"
        case Info:
            return "INFO"
        case Trace:
            return "TRACE"
        case Warn:
            return "WARN"
        }
    }
}

extension EventLevel: Equatable {}
//MARK: Equatable
public func == (lhs: EventLevel, rhs: EventLevel) -> Bool {
    return lhs.description == rhs.description
}

public struct Event {
    let created: NSDate = NSDate()
    let eventLevel: EventLevel
    let fileName: String
    let line: Int
    let message: String

    init(message: String, eventLevel: EventLevel, fileName: String, line: Int) {
        self.message = message
        self.eventLevel = eventLevel
        self.fileName = fileName
        self.line = line
    }
}
