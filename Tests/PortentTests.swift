//
//  PortentTests.swift
//  PortentTests
//
//  Created by Flemming Pedersen on 30/01/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import XCTest
@testable import Portent

final class PortentTests: XCTestCase {
    var logger: Portent!
    var mockReceiver: MockReceiver!

    let logString = "foo"
    let customLevelKey = "CUSTOM"

    let check: (loggedEvent: Event, expectedMessage: String, expectedEventLevelDescription: String) -> Void = { loggedEvent, logString, eventLevelDescription in
        XCTAssertEqual(loggedEvent.message, logString)
        XCTAssertEqual(loggedEvent.eventLevel.description, eventLevelDescription)
    }

    override func setUp() {
        super.setUp()

        mockReceiver = MockReceiver(eventLevels: [.Custom(key: customLevelKey), .Error, .Debug, .Info, .Trace, .Warn])

        logger = Portent()
        logger.addReceiver(receiver: mockReceiver)
    }

    override func tearDown() {

        super.tearDown()
    }

    //MARK: Tests
    func testCustom() {
        let data = MockData(name: logString)
        logger.custom(message: data, key: customLevelKey)

        check(loggedEvent: mockReceiver.eventLogged!, expectedMessage: logString, expectedEventLevelDescription: customLevelKey)
    }

    func testDebug() {
        logger.debug(message: logString)
        check(loggedEvent: mockReceiver.eventLogged!, expectedMessage: logString, expectedEventLevelDescription: "DEBUG")
    }

    func testError() {
        logger.error(message: logString)
        check(loggedEvent: mockReceiver.eventLogged!, expectedMessage: logString, expectedEventLevelDescription: "ERROR")
    }

    func testInfo() {
        logger.info(message: logString)
        check(loggedEvent: mockReceiver.eventLogged!, expectedMessage: logString, expectedEventLevelDescription: "INFO")
    }

    func testTrace() {
        logger.trace(message: logString)
        check(loggedEvent: mockReceiver.eventLogged!, expectedMessage: logString, expectedEventLevelDescription: "TRACE")
    }

    func testWarn() {
        logger.warn(message: logString)
        check(loggedEvent: mockReceiver.eventLogged!, expectedMessage: logString, expectedEventLevelDescription: "WARN")
    }
}
