//
//  MockReceiver.swift
//  Portent
//
//  Created by Flemming Pedersen on 11/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

@testable import Portent

final class MockReceiver {
    var eventLogged: Event?
    var eventTypes: [EventType]

    init(eventTypes: [EventType]) {
        self.eventTypes = eventTypes
    }
}

extension MockReceiver: EventReceiver {
//    var eventTypes: [EventType] {
//        return eventTypes
//    }

    func log(event: Event) {
        eventLogged = event
    }
}
