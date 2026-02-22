//
//  NavigationManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.11.24.
//

import Foundation

@Observable class NavigationManager {
    var selection: ViewPresentation = .finder
}

enum ViewPresentation: CaseIterable {
    case gemini
    case finder
    case tasks
    case schedule
    case settings
}
