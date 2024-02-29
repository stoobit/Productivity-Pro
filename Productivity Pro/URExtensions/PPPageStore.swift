//
//  PPPageStore.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.02.24.
//

import Foundation

extension PPPageModel {
    func store(_ item: PPItemModel) {
        store.append(item)
        version += 1
    }
}
