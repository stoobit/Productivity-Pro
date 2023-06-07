//
//  MarkupLabel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.06.23.
//

import SwiftUI

struct iOS17Label: View {
    
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        Label(
            "Markup",
            systemImage: toolManager.isCanvasEnabled ? "pencil.tip.crop.circle.fill" : "pencil.tip.crop.circle"
        )
    }
}

struct iOS16Label: View {
    
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        Label("Markup", systemImage: "pencil.tip.crop.circle")
            .foregroundStyle(
                toolManager.isCanvasEnabled ? Color.accentColor : Color.primary
            )
    }
}
