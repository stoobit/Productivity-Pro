import SwiftUI

struct NoteToolbar: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var hsc
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @AppStorage("defaultFont") var defaultFont: String = "Avenir Next"
    @AppStorage("defaultFontSize") var defaultFontSize: Double = 12
    @AppStorage("createdNotes") var createdNotes: Int = 0
    
    @Bindable var contentObject: ContentObject
    var size: CGSize
    
    var body: some ToolbarContent {
        @Bindable var subviewValue = subviewManager
        
        ToolbarItem(placement: .topBarLeading) {
            Button("Back", systemImage: "chevron.left") {
                dismissNote()
            }
        }
        
        ToolbarSpacer(placement: .topBarLeading)
            
        ToolbarItemGroup(placement: .topBarLeading) {
            Button("Bookmark", systemImage: bookmarkIcon) {
                toolManager.activePage?.isBookmarked.toggle()
            }
            .tint(Color.red)
            
            Button("Overview", systemImage: "square.grid.2x2") {
               openOverview()
            }
        }
        
        ToolbarSpacer(placement: .topBarLeading)
        
        ToolbarItem(placement: .topBarLeading) {
            Menu("Share", systemImage: "square.and.arrow.up") {
                ShareMenu(object: contentObject)
            }
        }
        
        ToolbarItemGroup(placement: .primaryAction) {
            PencilAction()
            InsertAction()
            InspectorAction()
        }
        
        ToolbarSpacer(placement: .primaryAction)
        
        ToolbarItemGroup(placement: .primaryAction) {
            UndoActions()
            ClipboardControl(size: size)
        }
        
        ToolbarSpacer(placement: .primaryAction)
        
        ToolbarItemGroup(placement: .primaryAction) {
            PageActions()
        }
    }
    
    func dismissNote() {
        contentObject.note?.recent = toolManager.activePage
        
        toolManager.activeItem = nil
        toolManager.pencilKit = false
        
        for page in contentObject.note!.pages! {
            page.store = []
        }
        
        dismiss()
    }
    
    func openOverview() {
        toolManager.pencilKit = false
        toolManager.activeItem = nil
        
        subviewManager.overview.toggle()
    }
    
    var bookmarkIcon: String {
        let isBookmarked = toolManager.activePage?.isBookmarked
        return isBookmarked == true ? "bookmark.fill" : "bookmark"
    }
}
