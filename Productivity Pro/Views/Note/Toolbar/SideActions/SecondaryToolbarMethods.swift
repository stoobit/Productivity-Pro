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
//        toolManager.selectedItem = document.note.pages[
//            toolManager.selectedPage
//        ].items.first(where: { $0.id == toolManager.selectedItem?.id })
//        
        subviewManager.showInspector.toggle()
    }
    
    func templateChangeDisabled() -> Bool {
        var isDisabled: Bool = true
        
//        if document.note.pages.indices.contains(toolManager.selectedPage) {
//            if document.note.pages[toolManager.selectedPage].type == .template {
//                isDisabled = false
//            }
//        }
        
        return isDisabled
    }
    
    func undo() {
        undoManager?.undo()
    }
    
    func redo() {
        undoManager?.redo()
    }
    
}
