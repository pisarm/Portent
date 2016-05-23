//
//  ApplicationEventGenerator.swift
//  Portent
//
//  Created by Flemming Pedersen on 08/02/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import Foundation
import UIKit

public final class AppDelegateGenerator {
    //MARK: Properties
    private let eventLevel: EventLevel
    private let logger: Portent

    //MARK: Life cycle
    public init(eventLevel: EventLevel = .Info, logger: Portent) {
        self.eventLevel = eventLevel
        self.logger = logger

        setupObservers()
    }

    deinit {
        NSNotificationCenter.default().removeObserver(self)
    }

    //MARK: Setup
    private func setupObservers() {
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
                NSNotificationCenter.default().addObserver(self, selector: #selector(log(notification:)), name: $0, object: nil)
            }
    }

    //MARK: Logging
    private dynamic func log(notification: NSNotification) {
        logger.log(message: notification.name, eventLevel: eventLevel)
    }
}
