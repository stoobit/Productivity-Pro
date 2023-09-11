//
//  SFSymbol.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import Foundation

class SFSymbols {

    /// Singleton instance.
    static let shared = SFSymbols()

    /// Array of all available symbol name strings.
    let allSymbols: [String]

    private init() {
        self.allSymbols = Self.fetchSymbols(fileName: "sfsymbol4")
    }

    private static func fetchSymbols(fileName: String) -> [String] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt"),
              let content = try? String(contentsOfFile: path) else {
            #if DEBUG
            assertionFailure("[SymbolPicker] Failed to load bundle resource file.")
            #endif
            return []
        }
        return content
            .split(separator: "\n")
            .map { String($0) }
    }

}
