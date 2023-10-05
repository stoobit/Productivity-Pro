//
//  CreateNoteView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI

struct CreateNoteView: View {
    @Environment(\.modelContext) var context
    var contentObjects: [ContentObject]
    
    @Binding var isPresented: Bool
    let parent: String
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    @AppStorage("ppgrade") var grade: Int = 5
    
    // MARK: Subview Values
    @State var selectTemplate: Bool = false
    @State var scanDocument: Bool = false
    @State var importPDF: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
                
                VStack {
                    ViewThatFits(in: .horizontal) {
                        CNGrid(axis: .horizontal, showIcon: true)
                        
                        ViewThatFits(in: .vertical) {
                            CNGrid(axis: .vertical, showIcon: true)
                            CNGrid(axis: .vertical, showIcon: false)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen", role: .cancel) {
                        isPresented.toggle()
                    }
                }
            }
            .sheet(isPresented: $selectTemplate) {
                TemplateView(
                    isPresented: $selectTemplate,
                    buttonTitle: "Erstellen"
                ) { isPortrait, template, color in
                    selectedTemplate(isPortrait, template, color)
                }
            }
            .fileImporter(
                isPresented: $importPDF,
                allowedContentTypes: [.pdf],
                allowsMultipleSelection: false
            ) { result in
                importedPDF(with: result)
            }
            .fullScreenCover(isPresented: $scanDocument) {
                ScannerView(cancelAction: { scanDocument = false }) { result in
                    scannedDocument(with: result)
                }
                .edgesIgnoringSafeArea(.all)
            }
            
        }
    }
}
