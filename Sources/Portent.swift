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

    //MARK: Receiver
    public func addReceiver(receiver: EventReceiver) {
        receivers.append(receiver)
    }
}

extension Portent {
    //MARK: Logging
    public func custom<M>(message: @autoclosure () -> M, key: String, fileName: String = #file, line: Int = #line) {
        propogate(message: message, eventLevel: .Custom(key: key), fileName: fileName, line: line)
    }

    public func debug<M>(message: @autoclosure () -> M, fileName: String = #file, line: Int = #line) {
        log(message: message, eventLevel: .Debug, fileName: fileName, line: line)
    }

    public func error<M>(message: @autoclosure () -> M, fileName: String = #file, line: Int = #line) {
        log(message: message, eventLevel: .Error, fileName: fileName, line: line)
    }

    public func info<M>(message: @autoclosure () -> M, fileName: String = #file, line: Int = #line) {
        log(message: message, eventLevel: .Info, fileName: fileName, line: line)
    }

    public func trace<M>(message: @autoclosure () -> M, fileName: String = #file, line: Int = #line) {
        log(message: message, eventLevel: .Trace, fileName: fileName, line: line)
    }

    public func warn<M>(message: @autoclosure () -> M, fileName: String = #file, line: Int = #line) {
        log(message: message, eventLevel: .Warn, fileName: fileName, line: line)
    }

    public func log<M>(message: @autoclosure () -> M, eventLevel: EventLevel, fileName: String = #file, line: Int = #line) {
        propogate(message: message, eventLevel: eventLevel, fileName: fileName, line: line)
    }
}

extension Portent {
    //MARK: Internal
    private func propogate<M>(message: @autoclosure () -> M, eventLevel: EventLevel, fileName: String = #file, line: Int = #line) {
        var event: Event?
        receivers.forEach {
            if $0.eventLevels.contains(eventLevel) {
                if event == nil {
                    event = Event(message: "\(message())", eventLevel: eventLevel, fileName: strip(path: fileName), line: line)
                }

                $0.log(event: event!)
            }
        }
    }

    private func strip(path: String) -> String {
        return path.characters
            .split { $0 == "/" }
            .map { String($0) }
            .last!
    }
}
