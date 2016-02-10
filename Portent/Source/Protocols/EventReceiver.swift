//
//  EventReceiver.swift
//  Portent
//
//  Created by Flemming Pedersen on 31/01/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

public protocol EventReceiver {
    var token: String? { get set }
    var eventTypes: [EventType] { get }
    func log(context: ManagedObjectContext, events: [Event])
}

public extension EventReceiver {
    var eventTypes: [EventType] {
        return [.Trace, .Debug, .Info, .Warn, .Error, .Fatal]
    }
}
