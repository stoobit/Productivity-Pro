//
//  DocumentCreationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.09.23.
//

import SwiftUI

struct DocumentCreationView: View {

    @Environment(\.dismiss) var dismiss
    @State var document: Document = Document()
    
    @State var isFolderPicker: Bool = false
    @State var isFailure: Bool = false
    
    @State var titel: String = ""
    @State var location: URL?
    @State var pinNote: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    TextField(getDate(), text: $titel)
                        .frame(height: 30)
                    
                    Button(
                        location == nil ? "Speicherort auswählen" : location!.lastPathComponent.string,
                        systemImage: "folder"
                    ) {
                        isFolderPicker.toggle()
                    }
                    .frame(height: 30)
                }
                
                Toggle(isOn: $pinNote) {
                    Label("Notiz anpinnen", systemImage: "pin")
                }
                .tint(.accentColor)
                .frame(height: 30)
                
                Section {
                    
                }
                
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationBarBackButtonHidden()
            .navigationTitle("Notiz erstellen")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Erstellen") { create() }
                }
            }
            .fileImporter(
                isPresented: $isFolderPicker,
                allowedContentTypes: [.folder],
                allowsMultipleSelection: false
            ) { result in
                importFolder(with: result)
            }
            .alert("Ein Fehler ist aufgetreten.", isPresented: $isFailure) {
                Button("Ok", role: .cancel) { isFailure = false }
            }
            
        }
    }
    
    func getDate() -> String {
        let today = Date.now
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        return formatter.string(from: today)
    }
    
    func create() {
        
    }
    
    func importFolder(with result: Result<[URL], any Error>) {
        switch result {
        case .success(let urls):
            
            if let document = urls.first {
                location = document
                isFolderPicker.toggle()
            } else {
                isFailure.toggle()
            }
            
        case .failure:
            isFailure.toggle()
        }
    }
}

#Preview {
    DocumentCreationView()
}
