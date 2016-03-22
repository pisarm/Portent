//
//  Portent.swift
//  Portent
//
//  Created by Flemming Pedersen on 30/01/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

public final class Portent {
    //MARK: Properties
    private var receivers: [EventReceiver]

    //MARK: Initialization
    public init() {
        self.receivers = []
    }

    //MARK:
    public func addReceiver(receiver: EventReceiver) {
        receivers.append(receiver)
    }
}

extension Portent {
    //MARK: Logging
    public func trace(message: String?, payload: [String:AnyObject]? = nil, fileName: String = #file, line: Int = #line) {
        log(.Trace, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func debug(message: String?, payload: [String:AnyObject]? = nil, fileName: String = #file, line: Int = #line) {
        log(.Debug, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func info(message: String?, payload: [String:AnyObject]? = nil, fileName: String = #file, line: Int = #line) {
        log(.Info, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func warn(message: String?, payload: [String:AnyObject]? = nil, fileName: String = #file, line: Int = #line) {
        log(.Warn, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func error(message: String?, payload: [String:AnyObject]? = nil, fileName: String = #file, line: Int = #line) {
        log(.Error, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func fatal(message: String?, payload: [String:AnyObject]? = nil, fileName: String = #file, line: Int = #line) {
        log(.Fatal, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func log(eventType: EventType, message: String? = nil, payload: [String:AnyObject]? = nil, fileName: String = #file, line: Int = #line) {
        if message == nil && payload == nil {
            return
        }

        let event = Event(fileName: stripPath(fileName), line: line, message: message, payload: payload, eventType: eventType)

        receivers
            .filter { $0.eventTypes.contains(eventType)}
            .forEach { $0.log(event) }
    }

    private func stripPath(path: String) -> String {
        return path.characters
            .split { $0 == "/" }
            .map { String($0) }
            .last!
    }
}
