//
//  ChooseTypeView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.09.22.
//

import SwiftUI

struct NewDocumentView: View {
    
    @Binding var isPresented: Bool
    @Binding var document: Document
    @Binding var url: URL?
    
    @State var title: String = ""
    @State var isPinned: Bool = false
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    @StateObject var subviewManager: SubviewManager
    @StateObject var toolManager: ToolManager
    
    @State var isPortrait: Bool = true
    @State var selectedColor: String = "pagewhite"
    @State var selectedTemplate: String = "blank"
    
    @State var isFailure: Bool = false
    @State var folderPicker: Bool = false
    @State var templatePicker: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    TextField("Unbenannt", text: $title)
                        .frame(height: 30)
                    
                    Button(
                        url == nil ? "Speicherort auswählen" : url!.lastPathComponent.string,
                        systemImage: "folder"
                    ) {
                        folderPicker.toggle()
                    }
                    .frame(height: 30)
                }
                
                Toggle(isOn: $isPinned) {
                    Label("Angepinnt", systemImage: "pin")
                }
                .tint(.accentColor)
                .frame(height: 30)
                
                Section {
                    Button(
                        "Letzte Vorlage",
                        systemImage: "clock.arrow.circlepath"
                    ) {
                        
                    }
                    .frame(height: 30)
                    
                    Button(
                        "Vorlage auswählen",
                        systemImage: "grid"
                    ) {
                        templatePicker.toggle()
                    }
                    .frame(height: 30)
                    
                    Button(
                        "Document scannen",
                        systemImage: "doc.viewfinder"
                    ) {
                        
                    }
                    .frame(height: 30)
                    
                    Button(
                        "PDF importieren",
                        systemImage: "doc.richtext"
                    ) {
                        
                    }
                    .frame(height: 30)
                }
                .disabled(url == nil)
            }
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.defaultMinListRowHeight, 10)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        isPresented.toggle()
                    }
                }
            }
        }
        .fileImporter(
            isPresented: $folderPicker,
            allowedContentTypes: [.folder],
            allowsMultipleSelection: false
        ) { result in
            importFolder(with: result)
        }
        .alert("Ein Fehler ist aufgetreten.", isPresented: $isFailure) {
            Button("Ok", role: .cancel) { isFailure = false }
        }
        .sheet(isPresented: $templatePicker) {
            TemplateView(
                isPresented: $templatePicker,
                isPortrait: $isPortrait,
                selectedColor: $selectedColor,
                selectedTemplate: $selectedTemplate,
                viewType: .create
            ) {
                folderPicker.toggle()
            }
        }
        
    }
}

#Preview {
   Text("")
        .sheet(isPresented: .constant(true)) {
            NewDocumentView(
                isPresented: .constant(true),
                document: .constant(Document()),
                url: .constant(nil),
                subviewManager: SubviewManager(),
                toolManager: ToolManager()
            )
        }
}
