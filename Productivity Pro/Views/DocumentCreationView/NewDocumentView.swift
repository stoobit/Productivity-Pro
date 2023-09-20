//
//  ChooseTypeView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.09.22.
//

import SwiftUI

struct NewDocumentView: View {
    
    @Binding var isPresented: Bool
    @Binding var showDocument: Bool
    
    @Binding var document: Document
    @Binding var url: URL
    
    @State var title: String = ""
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    @Bindable var subviewManager: SubviewManager
    @Bindable var toolManager: ToolManager
    
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
                        url == URL(string: "https://www.stoobit.com")! ? "Speicherort auswählen" : url.lastPathComponent.string,
                        systemImage: "folder"
                    ) {
                        folderPicker.toggle()
                    }
                    .frame(height: 30)
                }
                
                Section {
                    Button(
                        "Letzte Vorlage",
                        systemImage: "clock.arrow.circlepath"
                    ) {
                        createFromLastSelection()
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
                .disabled(url == URL(string: "https://www.stoobit.com")!)
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
        .sheet(isPresented: $templatePicker, onDismiss: {
            if document.documentType == .none {
                document = Document()
            }
        }) {
            TemplateView(
                isPresented: $templatePicker,
                isPortrait: $isPortrait,
                selectedColor: $selectedColor,
                selectedTemplate: $selectedTemplate,
                buttonTitle: "Erstellen"
            ) { createTemplate() }
        }
        
    }
}
