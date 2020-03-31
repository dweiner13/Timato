//
//  NotificationManager.swift
//  timer
//
//  Created by Dan Weiner on 3/28/20.
//  Copyright © 2020 Dan Weiner. All rights reserved.
//

import AppKit
import UserNotifications
import Combine

class NotificationManager {
    static let shared = NotificationManager()

    let center = UNUserNotificationCenter.current()

    var granted = false

    @discardableResult
    func requestAccess() -> Future<Bool, Error> {
        return .init { promise in
            self.center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(granted))
                }
            }
        }
    }

    @discardableResult
    func sendLocalNotification(title: String) -> Future<Void, Error> {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(
            identifier: NSUUID().uuidString,
            content: content,
            trigger: nil
        )

        return .init { promise in
            self.center.add(request) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
    }
}
