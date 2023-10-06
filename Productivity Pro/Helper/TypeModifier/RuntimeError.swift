//
//  RuntimeError.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 06.10.23.
//

import Foundation

struct RuntimeError: LocalizedError {
    let description: String

    init(_ description: String) {
        self.description = description
    }

    var errorDescription: String? {
        description
    }
}
