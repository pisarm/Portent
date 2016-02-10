//
//  CoreDataEventGenerator.swift
//  Portent
//
//  Created by Flemming Pedersen on 09/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import CoreData
import Foundation

final class CoreDataEventGenerator {
    private var context: ManagedObjectContext?
    private let eventType: EventType
    private let logger: PortentType

    init(observedContext context: ManagedObjectContext, eventType: EventType = .Info, logger: PortentType) {
        self.context = context
        self.eventType = eventType
        self.logger = logger

        setupObservers()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    private func setupObservers() {
        [NSManagedObjectContextWillSaveNotification,
            NSManagedObjectContextDidSaveNotification,
            ].forEach {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "log:", name: $0, object: context)
        }
    }

    private dynamic func log(notification: NSNotification) {
        //        if context == logger.context {
        //            return
        //        }
        //TODO: log inserted, updated, deleted objects (+ability to switch off) (LogLevel: Default, Verbose)
        //        logger.log(eventType, message: notification.name)
    }
}
