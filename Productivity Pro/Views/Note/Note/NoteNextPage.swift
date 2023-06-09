//
//  NoteNextPage.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.06.23.
//

import SwiftUI

struct NoteNextPage: View {
    
    @Binding var pages: [Page]
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        ZStack {
            Button("Next Page") {
                toolManager.selectedPage += 1
            }
            .keyboardShortcut(.rightArrow)
            .frame(width: 0, height: 0)
            .disabled(
                !pages.indices.contains(toolManager.selectedPage + 1)
            )
            
            Button("Previous Page") {
                toolManager.selectedPage -= 1
            }
            .keyboardShortcut(.leftArrow)
            .frame(width: 0, height: 0)
            .disabled(
                !pages.indices.contains(toolManager.selectedPage - 1)
            )
        }
    }
}
