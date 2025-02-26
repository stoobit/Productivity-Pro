

import Foundation

extension NoteToolbar {
    func toggleInspector() {
        let item = toolManager.activeItem
        toolManager.activeItem = nil
        toolManager.activeItem = item
        
        subviewManager.showInspector.toggle()
    }
}
