//
//  NoteSideActionMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import Foundation

extension NoteSideActions {
    
    func templateChangeDisabled() -> Bool {
        var isDisabled: Bool = true
        
        if document.note.pages.indices.contains(toolManager.selectedPage) {
            if document.note.pages[toolManager.selectedPage].type == .template {
                isDisabled = false
            }
        }
        
        return isDisabled
    }
    
    func undo() {
        undoManager?.undo()
    }
    
    func redo() {
        undoManager?.redo()
    }
    
}
