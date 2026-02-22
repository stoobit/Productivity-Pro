

import SwiftUI

extension NoteToolbar {
    @ViewBuilder func MediaButton() -> some View {
        Menu(content: {
            Section {
                Button(action: {
                    toolManager.pencilKit = false
                    subviewManager.takeMedia.toggle()
                }) {
                    Label("Take Photo", systemImage: "camera")
                }

                Button(action: {
                    toolManager.pencilKit = false
                    subviewManager.pickMedia.toggle()
                }) {
                    Label(
                        "Photo Library", systemImage: "photo.on.rectangle.angled"
                    )
                }
            }
        }) {
            Label("Image", systemImage: "photo")
        }
    }
}
