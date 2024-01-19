//
//  UVItem.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.01.24.
//

import SwiftUI

@Observable final class UVItem {
    var value: PPItemModel

    init(value: PPItemModel) {
        self.value = value
    }
}
