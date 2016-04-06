//
//  EventReceiver.swift
//  Portent
//
//  Created by Flemming Pedersen on 31/01/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation

public protocol EventReceiver {
    var eventLevels: [EventLevel] { get }
    func log(event: Event)
}
