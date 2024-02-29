//
//  URModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.02.24.
//

import Foundation

@Observable class URModel {
    var store: [ExportableNoteModel] = []
    var index: Int = 0
    
    var canUndo: Bool = false
    var canRedo: Bool = false
    
    func change(note: PPNoteModel) {
        let manager = ExportManager()
        let value = manager.export(note: note)
        
        store.append(value)
    }
    
    func undo() {}
    
    func redo() {}
}
