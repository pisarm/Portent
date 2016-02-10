//
//  Portent.swift
//  Portent
//
//  Created by Flemming Pedersen on 30/01/16.
//  Copyright © 2016 pisarm.dk. All rights reserved.
//

import CoreData
import Foundation

protocol PortentType {
    func trace(message: String?, payload: [String:AnyObject]?, fileName: String, line: Int64)
    func debug(message: String?, payload: [String:AnyObject]?, fileName: String, line: Int64)
    func info(message: String?, payload: [String:AnyObject]?, fileName: String, line: Int64)
    func warn(message: String?, payload: [String:AnyObject]?, fileName: String, line: Int64)
    func error(message: String?, payload: [String:AnyObject]?, fileName: String, line: Int64)
    func fatal(message: String?, payload: [String:AnyObject]?, fileName: String, line: Int64)
    func log(eventType: EventType, message: String?, payload: [String:AnyObject]?, fileName: String, line: Int64)
}

public final class Portent {
    private let context: ManagedObjectContext
    private var receivers: [EventReceiver] = []

    init(context: ManagedObjectContext = Stack.privateContext()) {
        assert(Stack.isValid(context))

        self.context = context

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didSave:", name: NSManagedObjectContextDidSaveNotification, object: context)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    public func register(var receiver: EventReceiver) -> String {
        let token = NSUUID().UUIDString
        receiver.token = token
        receivers.append(receiver)
        return token
    }

    public func unregister(token: String) {
        receivers = receivers.filter { $0.token != token }
    }
}

extension Portent: PortentType {
    //MARK: Logging
    public func trace(message: String?, payload: [String:AnyObject]? = nil, fileName: String = __FILE__, line: Int64 = __LINE__) {
        log(.Trace, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func debug(message: String?, payload: [String:AnyObject]? = nil, fileName: String = __FILE__, line: Int64 = __LINE__) {
        log(.Debug, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func info(message: String?, payload: [String:AnyObject]? = nil, fileName: String = __FILE__, line: Int64 = __LINE__) {
        log(.Info, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func warn(message: String?, payload: [String:AnyObject]? = nil, fileName: String = __FILE__, line: Int64 = __LINE__) {
        log(.Warn, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func error(message: String?, payload: [String:AnyObject]? = nil, fileName: String = __FILE__, line: Int64 = __LINE__) {
        log(.Error, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func fatal(message: String?, payload: [String:AnyObject]? = nil, fileName: String = __FILE__, line: Int64 = __LINE__) {
        log(.Fatal, message: message, payload: payload, fileName: fileName, line: line)
    }

    public func log(eventType: EventType, message: String? = nil, payload: [String:AnyObject]? = nil, fileName: String = __FILE__, line: Int64 = __LINE__) {
        if message == nil && payload == nil {
            return
        }

        context.performChanges { [unowned self] in
            self.receivers.forEach {
                if let token = $0.token {
                    let event = Event.insert(fileName: self.stripPath(fileName), line: line, token: token, context: self.context)
                    event.message = message
                    event.payload = payload
                }
            }
        }
    }
}

private extension Portent {
    //MARK: Internal
    private dynamic func didSave(notification: NSNotification) {
        guard let inserted = notification.userInfo?[NSInsertedObjectsKey], count = inserted.count where count > 0 else {
            return
        }

        do {
            let events = try Event.fetch(context)
            receivers.forEach { receiver in
                let filteredEvents = events.filter { event in event.token == receiver.token }
                receiver.log(context, events: filteredEvents)
            }
        } catch {
            print(error)    //TODO: how should this be handled?
        }
    }

    private func stripPath(path: String) -> String {
        return path.characters
            .split { $0 == "/" }
            .map { String($0) }
            .last!
    }
}
