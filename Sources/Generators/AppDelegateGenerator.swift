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
//    private let eventType: EventType
//    private let logger: Portent
//
//    public init(eventType: EventType = .Info, logger: Portent) {
//        self.eventType = eventType
//        self.logger = logger
//
//        setupObservers()
//    }
//
//    deinit {
//        NSNotificationCenter.defaultCenter().removeObserver(self)
//    }
//
//    private func setupObservers() {
//        [UIApplicationDidFinishLaunchingNotification,
//            UIApplicationWillEnterForegroundNotification,
//            UIApplicationDidBecomeActiveNotification,
//            UIApplicationWillResignActiveNotification,
//            UIApplicationDidEnterBackgroundNotification,
//            UIApplicationWillTerminateNotification,
//            UIApplicationDidReceiveMemoryWarningNotification,
//            UIApplicationSignificantTimeChangeNotification,
//            UIApplicationWillChangeStatusBarOrientationNotification,
//            UIApplicationDidChangeStatusBarOrientationNotification,
//            UIApplicationWillChangeStatusBarFrameNotification,
//            UIApplicationDidChangeStatusBarFrameNotification,
//            ].forEach {
//                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegateGenerator.log(_:)), name: $0, object: nil)
//        }
//    }
//
//    private dynamic func log(notification: NSNotification) {
//        guard let userInfo = notification.userInfo as? [String:AnyObject] else {
//            logger.log(eventType, message: notification.name)
//            return
//        }
//
//        logger.log(eventType, message: notification.name, payload: userInfo)
//    }
}
