//
//  LazyLoader.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 28.06.23.
//

import SwiftUI

struct LazyView<Content: View>: View {

    let build: () -> Content

    init(_ build: @autoclosure @escaping() -> Content ) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
