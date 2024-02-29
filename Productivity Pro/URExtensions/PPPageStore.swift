//
//  PPPageStore.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.02.24.
//

import Foundation

extension PPPageModel {
    func store(_ item: PPItemModel) {
        let storable = ExportManager().export(item: item)
        store.append(storable)
        
        version += 1
        print(version)
    }
}
