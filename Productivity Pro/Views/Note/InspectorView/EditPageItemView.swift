//
//  EditPageItemsView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.02.23.
//

import SwiftUI

struct EditPageItemView: View {
    
    var hsc: UserInterfaceSizeClass?
    @Binding var document: Document
    
    @Bindable var toolManager: ToolManager
    @Bindable var subviewManager: SubviewManager
    
    var body: some View {
        Group {
            if let item = toolManager.selectedItem {
                if item.type == .shape {
                    EditShapeItemView(
                        document: $document,
                        toolManager: toolManager,
                        subviewManager: subviewManager
                    )
                } else if item.type == .textField {
                    EditTextfieldItemView(
                        document: $document,
                        toolManager: toolManager,
                        subviewManager: subviewManager
                    )
                } else if item.type == .media {
                    EditMediaItemView(
                        document: $document,
                        toolManager: toolManager,
                        subviewManager: subviewManager
                    )
                }
            } else {
                Text("Select an Object")
                    .foregroundColor(.secondary)
            }
        }
        .frame(minWidth: hsc == .regular ? 390 : 0, minHeight: 530)
        .padding(.top, 5)
        .background(Color("PopoverColor"))
    }
}
