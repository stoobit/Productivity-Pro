import SwiftUI

extension NoteToolbar {
    @ViewBuilder func PageActions() -> some View {
        Menu(content: {
            Section {
                Button(action: {
                    toolManager.pencilKit = false
                    subviewManager.addPage = true
                }) {
                    Label("Add Page", systemImage: "doc.badge.plus")
                }

                Button(action: {
                    toolManager.pencilKit = false
                    subviewManager.importFile = true
                }) {
                    Label("Import PDF", systemImage: "square.and.arrow.down")
                }
            
                Button(action: {
                    toolManager.pencilKit = false
                    subviewManager.scanDocument = true
                }) {
                    Label("Scan Document", systemImage: "doc.text.fill.viewfinder")
                }
            }
            
            Section {
                Button(action: {
                    toolManager.pencilKit = false
                    subviewManager.changePage = true
                }) {
                    Label("Change Template", systemImage: "grid")
                }
                .disabled(toolManager.activePage?.type != PPPageType.template.rawValue)
                
                Button(role: .destructive, action: {
                    toolManager.pencilKit = false
                    subviewManager.deletePage = true
                }) {
                    Label("Delete Page", systemImage: "trash")
                }
                .disabled(contentObject.note?.pages?.count == 1)
            }
        }) {
            Label("Seitenaktionen", systemImage: "doc.badge.ellipsis")
        }
    }
}
