//
//  PPPageStore.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.02.24.
//

import Foundation

extension PPPageModel {
    func store(_ item: PPItemModel, action: @escaping () -> PPItemModel) {
        if store.isEmpty == false {
            store.removeLast()
        }
        
        if let index = store.indices.last {
            if index != version - 1 {
                store.removeSubrange(version...index)
            }
        }

        let storable = ExportManager().export(item: item)
        store.append(storable)
        version += 1

        let changed = ExportManager().export(item: action())
        store.append(changed)
    }

    func reset() {
        store = []
        version = 0
    }
}
