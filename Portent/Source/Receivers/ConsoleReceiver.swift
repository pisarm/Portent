//
//  ConsoleReceiver.swift
//  Portent
//
//  Created by Flemming Pedersen on 08/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

public final class ConsoleReceiver: EventReceiver {
    //MARK:
    public var token: String?

    public func log(context: ManagedObjectContext, events: [Event]) {
        events.forEach { event in
            var output = "\(event.eventType) \(event.fileName):\(event.line)"

            if let message = event.message {
                output += " \(message)"
            }

            if let payload = event.payload {
                output += " \(payload)"
            }

            print(output)

            context.performBlock {
                context.deleteObject(event)
            }
        }
        context.performBlock {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
