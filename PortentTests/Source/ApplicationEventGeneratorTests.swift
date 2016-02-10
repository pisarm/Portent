//
//  ApplicationEventGeneratorTests.swift
//  Portent
//
//  Created by Flemming Pedersen on 10/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation
import XCTest
@testable import Portent

class ApplicationEventGeneratorTests: XCTestCase {
    var context: ManagedObjectContext!
    var generators: [Any] = []
    var logger: Portent!

    override func setUp() {
        super.setUp()

        context = Stack.context(.InMemory, concurrencyType: .PrivateQueueConcurrencyType)
        logger = Portent(context: context)
        logger.register(ConsoleReceiver())

        generators.append(CoreDataEventGenerator(observedContext: context, eventType: .Info, logger: logger))
    }

    override func tearDown() {
        logger = nil

        super.tearDown()
    }

    func testEventGenerator() {

    }
}
