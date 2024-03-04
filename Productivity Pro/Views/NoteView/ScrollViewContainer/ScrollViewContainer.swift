//
//  ScrollViewContainer.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 27.06.23.
//

import SwiftUI

@MainActor
struct ScrollViewContainer: View {
    @Environment(ToolManager.self) var toolManager
    
    @Bindable var note: PPNoteModel
    @Bindable var page: PPPageModel
    
    var size: CGSize
    
    @State var scale: CGFloat = .zero
    @State var offset: CGPoint = .zero
    
    var body: some View {
        PPScrollView(
            isPortrait: page.isPortrait,
            size: size,
            scale: $scale,
            offset: $offset
        ) {
            PageView(
                note: note,
                page: page,
                scale: $scale,
                offset: $offset
            )
        }
        .background {
            VStack {
                Button("undo") {
                    toolManager.activePage?.undo()
                    toolManager.update += 1
                }
                .keyboardShortcut(KeyEquivalent("z"), modifiers: .command)
                
                Button("redo") {
                    toolManager.activePage?.redo()
                    toolManager.update += 1
                }
                .keyboardShortcut(KeyEquivalent("z"), modifiers: [
                    .command, .shift
                ])
            }
        }
        
        .modifier(OrientationUpdater(isPortrait: page.isPortrait))
    }
}
