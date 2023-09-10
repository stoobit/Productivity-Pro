//
//  TemplateSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct TemplateSettings: View {
    
    @State var isTutorialPresented: Bool = false
    @State var isImporterPresented: Bool = false
    
    @State var failedImport: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button(action: { isTutorialPresented.toggle() }) {
                        HStack {
                            Text("Erstelle deine eigenen Vorlagen.")
                            Spacer()
                            Image(systemName: "info.circle")
                        }
                        .foregroundStyle(.blue)
                    }
                }
                .listRowBackground(Color.blue.opacity(0.13))
                .padding(.vertical, 8)
                
                Section {
                    Button(action: { isImporterPresented.toggle() }) {
                        HStack {
                            Text("Vorlagen importieren")
                                .foregroundStyle(Color.primary)
                            Spacer()
                            Image(systemName: "plus")
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding(.vertical, 8)
                .fileImporter(
                    isPresented: $isImporterPresented,
                    allowedContentTypes: [.svg],
                    allowsMultipleSelection: false
                ) { result in importSVGFiles(result: result) }
                
                Section {
                    
                }
            }
            .navigationTitle("Vorlagen")
        }
        .fullScreenCover(isPresented: $isTutorialPresented) {
            
        }
        .alert("Import fehlgeschlagen.", isPresented: $failedImport) {
            Button("Ok", role: .cancel) { failedImport = false }
        }
    }
}

#Preview {
    TemplateSettings()
}
