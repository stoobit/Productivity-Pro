//
//  NoteSideActionMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.06.23.
//

import Foundation

extension NoteSideActionToolbar {
    
    func templateChangeDisabled() -> Bool {
        var isDisabled: Bool = true
        
        if document.document.note.pages.indices.contains(toolManager.selectedPage) {
            if document.document.note.pages[toolManager.selectedPage].type == .template {
                isDisabled = false
            }
        }
        
        return isDisabled
    }
    
    func tapPresentationButton() {
        let dateTrialEnd = Calendar.current.date(
            byAdding: .day,
            value: freeTrialDays,
            to: Date(rawValue: startDate)!
        )
        
        if !isFullAppUnlocked && dateTrialEnd! < Date() {
            subviewManager.showUnlockView = true
        } else {
            subviewManager.isPresentationMode.toggle()
            
            if subviewManager.isPresentationMode == false {
                Task {
                    try? await Task.sleep(nanoseconds: 50000)
                    undoManager?.removeAllActions()
                }
            }
        }
    }
    
    func undo() {
        undoManager?.undo()
    }
    
    func redo() {
        undoManager?.redo()
    }
    
}
