//
//  ImportProNote.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.12.23.
//

import PencilKit
import SwiftUI

extension ObjectView {
    func importProNote(url: URL) throws {
        let contentObject = try ImportManager()
            .ppImport(
                from: url, to: parent, with: grade
            )
        
        context.insert(contentObject)
    }
}
