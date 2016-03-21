//
//  ConsoleReceiver.swift
//  Portent
//
//  Created by Flemming Pedersen on 08/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

public final class ConsoleReceiver {
    private let serialQueue: dispatch_queue_t = dispatch_queue_create("ConsoleReceiverQueue", DISPATCH_QUEUE_SERIAL)
}

extension ConsoleReceiver: EventReceiver {
    //MARK: EventReceiver
    public var eventTypes: [EventType] {
        return [.Trace, .Debug, .Info, .Warn, .Error, .Fatal]
    }

    public func log(event: Event) {
        var output = "\(event.type) \(event.fileName):\(event.line)"

        if let message = event.message {
            output += " \(message)"
        }

        if let payload = event.payload {
            output += " \(payload)"
        }

        dispatch_async(serialQueue) {
            print(output)
        }
    }
}
