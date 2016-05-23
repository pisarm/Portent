//
//  AppDelegateGeneratorTests.swift
//  Portent
//
//  Created by Flemming Pedersen on 10/05/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import UIKit
import XCTest
@testable import Portent

final class AppDelegateGeneratorTests: XCTestCase {
    var generator: AppDelegateGenerator!
    var logger: Portent!
    var mockReceiver: MockReceiver!

    override func setUp() {
        super.setUp()

        let eventLevel: EventLevel = .Info

        mockReceiver = MockReceiver(eventLevels: [eventLevel])

        logger = Portent()
        logger.addReceiver(receiver: mockReceiver)

        generator = AppDelegateGenerator(eventLevel: eventLevel, logger: logger)
    }

    override func tearDown() {
        super.tearDown()
    }

    //MARK: Tests
    func testNotifications() {
        [UIApplicationDidFinishLaunchingNotification,
            UIApplicationWillEnterForegroundNotification,
            UIApplicationDidBecomeActiveNotification,
            UIApplicationWillResignActiveNotification,
            UIApplicationDidEnterBackgroundNotification,
            UIApplicationWillTerminateNotification,
            UIApplicationDidReceiveMemoryWarningNotification,
            UIApplicationSignificantTimeChangeNotification,
            UIApplicationWillChangeStatusBarOrientationNotification,
            UIApplicationDidChangeStatusBarOrientationNotification,
            UIApplicationWillChangeStatusBarFrameNotification,
            UIApplicationDidChangeStatusBarFrameNotification]
            .forEach {
                NSNotificationCenter.default().post(name: $0, object: nil)
                XCTAssertEqual(mockReceiver.eventLogged?.message, $0)
            }
    }
}
