//
//  PPPageRedo.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.02.24.
//

import Foundation

extension PPPageModel {
    var canRedo: Bool {
        if store.count == 0 {
            return false
        }

        return version == store.count - 1 ? false : true
    }

    func redo(toolManager: ToolManager) {
        version += 1
        let activeID = toolManager.activeItem?.id

        guard let items = items else { return }
        let stored = store[version]

        let item = ImportManager().ppImport(item: stored)
        let active = items.first(where: { $0.id == stored.id })
        self.items?.removeAll(where: { $0 == active })
        self.items?.append(item)
        
        toolManager.activeItem = self.items?.first(where: {
            $0.id == activeID
        })
    }
}
