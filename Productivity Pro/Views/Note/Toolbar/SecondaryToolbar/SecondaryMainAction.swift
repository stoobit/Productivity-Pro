//
//  NoteSideMainAction.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.10.23.
//

import SwiftUI

extension NoteSecondaryToolbar {
    @ViewBuilder func MainAction() -> some View {
        @Bindable var subviewValue = subviewManager
        
        Button(action: { toggleInspector() }) {
            Label("Inspektor", systemImage: "paintbrush")
        }
        .disabled(toolManager.activeItem == nil)
        .popover(isPresented: $subviewValue.showInspector) {
            InspectorView(contentObject: contentObject)
                .frame(width: 320, height: 380)
                .presentationCompactAdaptation(.popover)
        }
    }
}
