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
    //MARK: Properties
    private var context: NSManagedObjectContext?
    private let eventLevel: EventLevel
    private let logger: Portent

    //MARK: Life cycle
    public init(observedContext context: NSManagedObjectContext?, logger: Portent, eventLevel: EventLevel = .Info) {
        self.context = context
        self.logger = logger
        self.eventLevel = eventLevel

        setupObservers()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    //MARK: Setup
    private func setupObservers() {
        [ NSManagedObjectContextWillSaveNotification, NSManagedObjectContextDidSaveNotification ]
            .forEach {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(log(_:)), name: $0, object: context)
            }
    }

    //MARK: Logging
    private dynamic func log(notification: NSNotification) {
        //TODO: Log insert/updated/deleted objects (remember thread safety)
        logger.log("\(context?.name): \(notification.name)", eventLevel: eventLevel)
    }
}
