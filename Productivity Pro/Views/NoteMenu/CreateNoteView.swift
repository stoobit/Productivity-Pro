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
    
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    @AppStorage("ppDateOpened") var date: Date = .init()
    
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
        VStack {
            if isUnlocked == false && Date() > Date.freeTrial(date) {
                Button("Notiz erstellen", systemImage: "plus") {
                    purchaseView.toggle()
                }
            } else {
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
            }
        }
        .sheet(isPresented: $purchaseView, content: {
            PurchaseView {}
                .interactiveDismissDisabled()
        })
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
