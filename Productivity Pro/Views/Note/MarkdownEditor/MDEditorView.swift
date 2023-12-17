//
//  RTFEditorView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.12.23.
//

import SwiftUI

struct MDEditorView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @Environment(ToolManager.self) var toolManager

    var body: some View {
        @Bindable var textField = toolManager.activeItem!.textField!

        NavigationStack {
//            SwiftDownEditor(text: $textField.string)
//                .insetsSize(10)
//                .theme(theme)
            TextEditor(text: $textField.string)
        }
    }

//    var theme: Theme {
//        if colorScheme == .light {
//            Theme.BuiltIn.defaultLight.theme()
//        } else {
//            Theme.BuiltIn.defaultLight.theme()
//        }
//    }
}
