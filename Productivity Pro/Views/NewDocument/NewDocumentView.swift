//
//  ChooseTypeView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.09.22.
//

import SwiftUI

struct NewDocumentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var document: Document
    @StateObject var subviewManager: SubviewManager
    
    @State var selection: String = "Note"
    
    var body: some View {
        GeometryReader { reader in
            NavigationStack {
                VStack {
                    if selection == "Note" {
                        NoteSettings(
                            subviewManager: subviewManager, document: $document
                        ) {
                            close()
                        }
                    } else if selection == "Whiteboard" {
                        WhiteboardSettings(document: $document) { close() }
                    } else if selection == "Task List" {
                        TaskListSettings(document: $document) { close() }
                    }
                }
                .navigationTitle("New \(selection)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarRole(.browser)
                .toolbarBackground(.visible, for: .navigationBar)
                
            }
            .interactiveDismissDisabled()
        }
    }
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct ChooseTypeView_Previews: PreviewProvider {
    static var previews: some View {
        Spacer()
            .sheet(isPresented: .constant(true)) {
                
            }
    }
}
