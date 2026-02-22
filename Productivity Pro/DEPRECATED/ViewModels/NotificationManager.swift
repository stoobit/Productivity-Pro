//
//  NotificationManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.11.24.
//

import UserNotifications

@Observable class NotificationManager {
    func askPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
    }
}
