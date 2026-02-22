//
//  Homework.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.09.23.
//

import SwiftData
import SwiftUI

@Model final class Homework: Identifiable {
    
    init() { }
    
    init(
        title: LocalizedStringResource,
        subject: LocalizedStringResource,
        date: Date
    ) {
        self.title = String(localized: title)
        self.subject = String(localized: subject)
        self.date = date
    }
    
    var id: UUID = UUID()
    
    var title: String = ""
    var homeworkDescription: String = ""
    
    var subject: String = ""
    var date: Date = Date()
    
    var note: ContentObject?
}
