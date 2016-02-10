//
//  MockReceiver.swift
//  Portent
//
//  Created by Flemming Pedersen on 11/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

@testable import Portent

final class MockReceiver: EventReceiver {
    var token: String?
    var eventTypes: [EventType]

    init(eventTypes: [EventType] = [.Trace, .Debug, .Info, .Warn, .Error, .Fatal]) {
        self.eventTypes = eventTypes
    }

    func log(context: ManagedObjectContext, events: [Event]) {

    }
}
