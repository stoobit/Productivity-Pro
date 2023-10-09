//
//  MediaButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.10.23.
//

import SwiftUI

extension NoteMainToolbar {
    @ViewBuilder func MediaButton() -> some View {
        Menu(content: {
            
            Section {
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.showCameraView.toggle()
                }) {
                    Label("Kamera", systemImage: "camera")
                }
                
                Button(action: {
                    toolManager.isCanvasEnabled = false
                    subviewManager.showImportPhoto.toggle()
                }) {
                    Label("Fotos", systemImage: "photo.on.rectangle.angled")
                }
            }
            
            Button(action: {
                toolManager.isCanvasEnabled = false
                subviewManager.showImportMedia.toggle()
            }) {
                Label("Dateien durchsuchen", systemImage: "folder")
            }
            
        }) {
            Label("Bild", systemImage: "photo")
        }
        .modifier(
            ImportMediaHelper(
                toolManager: toolManager,
                subviewManager: subviewManager,
                document: $document
            )
        )
        
    }
}
