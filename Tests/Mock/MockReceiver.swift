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
    var eventLogged: Event?
    var eventLevels: [EventLevel]

    init(eventLevels: [EventLevel]) {
        self.eventLevels = eventLevels
    }

    func log(event: Event) {
        eventLogged = event
    }
}
