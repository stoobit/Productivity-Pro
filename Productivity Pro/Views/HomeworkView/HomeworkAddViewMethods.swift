//
//  HomeworkAddViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.04.24.
//

import SwiftUI

extension HomeworkAddView {
    func add() {
        homework.date = Calendar.current.date(
            bySettingHour: 5, minute: 00, second: 0, of: homework.date
        )!
        
        homework.note = contentObjects.first(where: {
            $0.id.uuidString == pickedNote
        })
    
        context.insert(homework)
        pushNotification()
        
        isPresented.toggle()
    }
    
    func pushNotification() {
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        content.title = homework.title
        content.body = String(localized:
            "Diese Aufgabe ist bis morgen in \(homework.subject) zu erledigen."
        )
        
        let calendar = Calendar.current
        let date = Calendar.current.date(
            byAdding: .day, value: -1, to: homework.date
        )!
        
        let component = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: calendar.component(.year, from: date),
            month: calendar.component(.month, from: date),
            day: calendar.component(.day, from: date),
            hour: calendar.component(.hour, from: notificationTime),
            minute: calendar.component(.minute, from: notificationTime)
        )
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: component, repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: homework.id.uuidString,
            content: content, trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
    
    func edgeInsets() -> EdgeInsets {
        var insets = EdgeInsets()
        let value: CGFloat = 5
        
        insets.leading = value
        insets.trailing = value
        
        return insets
    }
}
