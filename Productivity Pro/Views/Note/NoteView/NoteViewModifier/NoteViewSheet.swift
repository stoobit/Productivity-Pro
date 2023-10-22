//
//  NoteSheetHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.11.22.
//

import SwiftUI
import PencilKit
import PDFKit

struct NoteViewSheet: ViewModifier {
    @Environment(\.undoManager) var undoManager
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    @State var isPortrait: Bool = false
    @State var selectedColor: String = ""
    @State var selectedTemplate: String = ""
    
    var contentObject: ContentObject
    func body(content: Content) -> some View {
        @Bindable var manager = subviewManager
        
        content
            .sheet(isPresented: $manager.addPage, content: {
                
            })
            .sheet(isPresented: $manager.importFile, content: {
                
            })
            .sheet(isPresented: $manager.scanDocument, content: {
                
            })
            .sheet(isPresented: $manager.changePage, content: {
                
            })
            .sheet(isPresented: $manager.overview, content: {
                
            })
            .alert("", isPresented: $manager.deletePage) {
                Button("") {
                    
                }
                
                Button("") {
                    
                }
            }
//            .background {
//                if subviewManager.showPrinterView {
//                    if let url = toolManager.pdfRendering {
//                        PrinterView(
//                            document: $document,
//                            subviewManager: subviewManager,
//                            url: url
//                        )
//                    }
//                }
//            }
            
    }
    
    
    
}
