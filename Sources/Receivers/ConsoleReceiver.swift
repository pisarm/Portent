//
//  ConsoleReceiver.swift
//  Portent
//
//  Created by Flemming Pedersen on 08/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

public final class ConsoleReceiver {
    //MARK: Properties
    private let serialQueue: dispatch_queue_t
    //TODO: Date formatter (overridable - used to prefix output)

    //MARK: Initialization
    public init() {
        self.serialQueue = dispatch_queue_create("ConsoleReceiverQueue", DISPATCH_QUEUE_SERIAL)
    }
}

extension ConsoleReceiver: EventReceiver {
    //MARK: EventReceiver
    public var eventLevels: [EventLevel] {
        return [.Debug, .Error, .Info, .Trace, .Warn]
    }

    public func log(event: Event) {
        let output = "\(event.eventLevel.description) \(event.fileName):\(event.line) \(event.message)"
        dispatch_async(serialQueue) {
            print(output)
        }
    }
}
