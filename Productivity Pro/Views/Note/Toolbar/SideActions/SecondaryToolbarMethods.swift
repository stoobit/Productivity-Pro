//
//  NoteSideActionMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import Foundation

extension NoteSecondaryToolbar {
    
    func toggleOverview() {
        toolManager.isCanvasEnabled = false
        subviewManager.overviewSheet.toggle()
    }
    
    func toggleInspector() {
        let item = activeItem
        activeItem = nil
        activeItem = item
        
        subviewManager.showInspector.toggle()
    }
    
    func templateChangeDisabled() -> Bool {
//        var isDisabled: Bool = true
        
//        if document.note.pages.indices.contains(toolManager.selectedPage) {
//            if document.note.pages[toolManager.selectedPage].type == .template {
//                isDisabled = false
//            }
//        }
        
        return true
    }
    
    func undo() {
        undoManager?.undo()
    }
    
    func redo() {
        undoManager?.redo()
    }
    
}
