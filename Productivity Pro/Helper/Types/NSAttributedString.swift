//
//  NSAttributedString.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.24.
//

import Foundation

public extension NSAttributedString {
    convenience init(data: Data) {
        do {
            try self.init(data: data, documentAttributes: nil)
        } catch {
            self.init(string: String(
                localized: "Ein Fehler ist aufgetreten."
            ))
        }
    }

    func data() -> Data {
        do {
            return try self.data(
                from: .init(location: 0, length: self.length),
                documentAttributes: [
                    .documentType: NSAttributedString.DocumentType.rtf
                ]
            )
        } catch {
            return Data()
        }
    }
}
