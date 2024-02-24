//
//  UVPage.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.01.24.
//

import SwiftUI

@Observable final class UVPage {
    var value: PPPageModel

    init(value: PPPageModel) {
        self.value = value
    }
}
