import SwiftUI

extension NoteToolbar {
    @ViewBuilder func InsertAction() -> some View {
        Menu("Einfügen", systemImage: "plus") {
            ShapesButton()
            MediaButton()
            TextFieldButton()
        }
    }
}
