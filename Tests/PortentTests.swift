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
    let customName = "BAR"

    override func setUp() {
        super.setUp()

        mockReceiver = MockReceiver(eventTypes: [.Trace, .Debug, .Info, .Warn, .Error, .Fatal, .Custom(name: customName)])

        logger = Portent()
        logger.addReceiver(mockReceiver)
    }

    override func tearDown() {


        super.tearDown()
    }

    func testLogTraceMessage() {
        logger.trace(logString)

        let event = mockReceiver.eventLogged!

        XCTAssertEqual(event.message!, logString)
        XCTAssertEqual("TRACE", event.type)
    }

    func testLogDebugMessage() {
        logger.debug(logString)

        let event = mockReceiver.eventLogged!

        XCTAssertEqual(event.message!, logString)
        XCTAssertEqual("DEBUG", event.type)
    }

    func testLogInfoMessage() {
        logger.info(logString)

        let event = mockReceiver.eventLogged!

        XCTAssertEqual(event.message!, logString)
        XCTAssertEqual("INFO", event.type)
    }

    func testLogWarnMessage() {
        logger.warn(logString)

        let event = mockReceiver.eventLogged!

        XCTAssertEqual(event.message!, logString)
        XCTAssertEqual("WARN", event.type)
    }

    func testLogErrorMessage() {
        logger.error(logString)

        let event = mockReceiver.eventLogged!

        XCTAssertEqual(event.message!, logString)
        XCTAssertEqual("ERROR", event.type)
    }

    func testLogFatalMessage() {
        logger.fatal(logString)

        let event = mockReceiver.eventLogged!

        XCTAssertEqual(event.message!, logString)
        XCTAssertEqual("FATAL", event.type)
    }

    func testLogCustomMessage() {
        logger.log(.Custom(name: customName), message: logString)

        let event = mockReceiver.eventLogged!

        XCTAssertEqual(event.message!, logString)
        XCTAssertEqual(customName, event.type)
    }
}
