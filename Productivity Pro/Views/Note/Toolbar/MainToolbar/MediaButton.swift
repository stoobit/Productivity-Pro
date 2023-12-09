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
                    toolManager.pencilKit = false
                    subviewManager.takeMedia.toggle()
                }) {
                    Label("Kamera", systemImage: "camera")
                }
                
                Button(action: {
                    toolManager.pencilKit = false
                    subviewManager.pickMedia.toggle()
                }) {
                    Label("Fotos", systemImage: "photo.on.rectangle.angled")
                }
            }
            
            Button(action: {
                toolManager.pencilKit = false
                subviewManager.importMedia.toggle()
            }) {
                Label("Dateien durchsuchen", systemImage: "folder")
            }
            
        }) {
            Label("Bild", systemImage: "photo")
        }
        .modifier(MediaImport(contentObject: contentObject))
        
    }
}
