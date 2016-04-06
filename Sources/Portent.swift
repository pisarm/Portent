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
    public func custom<M>(@autoclosure message: () -> M, key: String, fileName: String = #file, line: Int = #line) {
        propogate(message, eventLevel: .Custom(key: key), fileName: fileName, line: line)
    }

    public func debug<M>(@autoclosure message: () -> M, fileName: String = #file, line: Int = #line) {
        log(message, eventLevel: .Debug, fileName: fileName, line: line)
    }

    public func error<M>(@autoclosure message: () -> M, fileName: String = #file, line: Int = #line) {
        log(message, eventLevel: .Error, fileName: fileName, line: line)
    }

    public func info<M>(@autoclosure message: () -> M, fileName: String = #file, line: Int = #line) {
        log(message, eventLevel: .Info, fileName: fileName, line: line)
    }

    public func trace<M>(@autoclosure message: () -> M, fileName: String = #file, line: Int = #line) {
        log(message, eventLevel: .Trace, fileName: fileName, line: line)
    }

    public func warn<M>(@autoclosure message: () -> M, fileName: String = #file, line: Int = #line) {
        log(message, eventLevel: .Warn, fileName: fileName, line: line)
    }
}

extension Portent {
    //MARK: Internal
    private func log<M>(@autoclosure message: () -> M, eventLevel: EventLevel, fileName: String = #file, line: Int = #line) {
        propogate(message, eventLevel: eventLevel, fileName: fileName, line: line)
    }

    private func propogate<M>(@autoclosure message: () -> M, eventLevel: EventLevel, fileName: String = #file, line: Int = #line) {
        var event: Event?
        receivers.forEach {
            if $0.eventLevels.contains(eventLevel) {
                if event == nil {
                    event = Event(message: "\(message())", eventLevel: eventLevel, fileName: stripPath(fileName), line: line)
                }

                $0.log(event!)
            }
        }
    }

    private func stripPath(path: String) -> String {
        return path.characters
            .split { $0 == "/" }
            .map { String($0) }
            .last!
    }
}
