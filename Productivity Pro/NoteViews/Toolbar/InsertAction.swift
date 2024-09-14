//
//  SecondaryInsertAction.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.09.24.
//

import SwiftUI

extension NoteToolbar {
    @ViewBuilder func InsertAction() -> some View {
        Menu("Einfügen", systemImage: "plus") {
            ShapesButton()
            TextFieldButton()
            MediaButton()
        }
    }
}
