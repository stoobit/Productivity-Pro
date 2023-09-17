//
//  MarkupLabel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.06.23.
//

import SwiftUI

struct iOS17Label: View {
    
    @Bindable var toolManager: ToolManager
    
    var body: some View {
        Label(
            "Drawing",
            systemImage: toolManager.isCanvasEnabled ? "pencil.tip.crop.circle.fill" : "pencil.tip.crop.circle"
        )
    }
}

struct iOS16Label: View {
    
    @Bindable var toolManager: ToolManager
    
    var body: some View {
        Label("Drawing", systemImage: "pencil.tip")
            .foregroundStyle(
                toolManager.isCanvasEnabled ? Color.accentColor : Color.primary
            )
    }
}
