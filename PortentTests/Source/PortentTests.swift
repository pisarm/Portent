//
//  PortentTests.swift
//  PortentTests
//
//  Created by Flemming Pedersen on 30/01/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import XCTest
@testable import Portent

class PortentTests: XCTestCase {
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

    func testPortent() {
        logger.info("test")
//        logger.trace("test")
//        let hat = Something(fishy: "fjæsing")
//        (0..<500).forEach { _ in
//            logger.trace("testing")
//        }


//        logger.info("fiskehat")
    }
}
