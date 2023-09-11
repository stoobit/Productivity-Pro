//
//  TemplateSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI
import SVGKit

struct TemplateSettings: View {
    
    @AppStorage("pptemplates") var importedTemplates: CodableWrapper<Array<TemplateModel>> = .init(value: .init())
    
    @State var isTutorialPresented: Bool = false
    @State var isImporterPresented: Bool = false
    
    @State var failedImport: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    List(importedTemplates.value, id: \.self) { template in
                        
                        SVGKFastImageViewSUI(
                            data: template.data,
                            size: CGSize(width: 140, height: 198)
                        )
                        
                    }
                }
                
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

            }
            .navigationTitle("Vorlagen")
        }
        .fullScreenCover(isPresented: $isTutorialPresented) {
            
        }
        .alert("Import fehlgeschlagen.", isPresented: $failedImport) {
            Button("Ok", role: .cancel) { failedImport = false }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("", systemImage: "plus") { 
                    isImporterPresented.toggle()
                }
            }
        }
        .fileImporter(
            isPresented: $isImporterPresented,
            allowedContentTypes: [.svg],
            allowsMultipleSelection: false
        ) { result in importSVGFiles(result: result) }
    }
}

#Preview {
    TemplateSettings()
}
