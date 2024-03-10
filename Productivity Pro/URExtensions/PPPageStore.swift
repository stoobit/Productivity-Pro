//
//  PPPageStore.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.02.24.
//

import Foundation

extension PPPageModel {
    func store(
        _ item: PPItemModel,
        type: StoreType = .default,
        action: @escaping () -> PPItemModel
    ) {
        if store.isEmpty == false {
            store.removeLast()
        }

        if let index = store.indices.last {
            if index != version - 1 {
                store.removeSubrange(version ... index)
            }
        }

        var storable = ExportManager().export(item: item)
        if type == .create {
            storable.isDeleted = true
        }
        
        store.append(storable)
        version += 1

        var changed = ExportManager().export(item: action())
        if type == .delete {
            changed.isDeleted = true
        }
        
        store.append(changed)
    }

    func reset() {
        store = []
        version = 0
    }
}

enum StoreType {
    case `default`
    case delete
    case create
}
