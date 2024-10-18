//
//  CreateNoteView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI

struct CreateNoteView: View {
    @Environment(\.modelContext) var context
    @Environment(ToolManager.self) var toolManager
    
    var contentObjects: [ContentObject]
    let parent: String
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = "pagewhite"
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = "blank"
    
    @AppStorage("ppgrade") var grade: Int = 5
    
    @State var selectTemplate: Bool = false
    @State var scanDocument: Bool = false
    @State var purchaseView: Bool = false
    
    @Binding var importFile: Bool
    
    var body: some View {
        Menu("Notiz erstellen", systemImage: "plus") {
            Button("Vorlage auswählen", systemImage: "grid") {
                selectTemplate.toggle()
            }
            
            Button("Datei importieren", systemImage: "square.and.arrow.down") {
                importFile.toggle()
            }
            
            Button("Dokument scannen", systemImage: "doc.viewfinder") {
                scanDocument.toggle()
            }
        }
        .sheet(isPresented: $selectTemplate) {
            TemplateView(
                isPresented: $selectTemplate,
                buttonTitle: "Erstellen"
            ) { isPortrait, template, color, title in
                selectedTemplate(isPortrait, template, color, title)
            }
        }
        .fullScreenCover(isPresented: $scanDocument) {
            ScannerView(cancelAction: { scanDocument = false }) { result in
                scannedDocument(with: result)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
