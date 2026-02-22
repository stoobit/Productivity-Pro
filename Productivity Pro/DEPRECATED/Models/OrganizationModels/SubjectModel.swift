//
//  Subject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct Subject: Identifiable, Codable, Equatable, Hashable {
    init(id: UUID = UUID(), title: LocalizedStringResource, icon: String, color: String) {
        self.id = id
        self.title = String(localized: title)
        self.icon = icon
        self.color = color
    }
    
    init(title: LocalizedStringResource, icon: String, color: String) {
        self.title = String(localized: title)
        self.icon = icon
        self.color = color
    }
    
    init(title: LocalizedStringResource, icon: String, color: Color) {
        self.title = String(localized: title)
        self.icon = icon
        self.color = color.rawValue
    }
    
    init(icon: String) {
        self.icon = icon
    }
    
    init() {
        
    }
    
    var id = UUID()
    
    var title: String = ""
    var icon: String = ""
    var color: String = ""
}
