//
//  CoreDataEventGenerator.swift
//  Portent
//
//  Created by Flemming Pedersen on 09/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import CoreData
import Foundation

public final class CoreDataGenerator {
    private var context: NSManagedObjectContext?
    private let eventType: EventType
    private let logger: Portent

    public init(observedContext context: NSManagedObjectContext, eventType: EventType = .Info, logger: Portent) {
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
        //TODO: Log inserted/updated/deleted objects (name? objectID?) notification.userInfo as payload?
        logger.log(eventType, message: notification.name)
    }
}
