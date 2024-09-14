//
//  NoteSideActionMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import Foundation

extension NoteToolbar {
    func toggleInspector() {
        let item = toolManager.activeItem
        toolManager.activeItem = nil
        toolManager.activeItem = item
        
        subviewManager.showInspector.toggle()
    }
}
