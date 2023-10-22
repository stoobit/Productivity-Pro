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
    
    var contentObject: ContentObject
    func body(content: Content) -> some View {
        @Bindable var manager = subviewManager
        
        content
            .sheet(isPresented: $manager.addPage, content: {
                TemplateView(
                    isPresented: $manager.addPage,
                    buttonTitle: "Hinzufügen"
                ) { isPortrait, template, color in
                    addPage(isPortrait, template, color)
                }
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
    
    func addPage(_ portrait: Bool, _ template: String, _ color: String) {
        let page: PPPageModel = PPPageModel(
            type: .template,
            canvas: .pkCanvas,
            index: getIndex()
        )
        
        page.isPortrait = portrait
        page.template = template
        page.color = color
        
        contentObject.note?.pages?.append(page)
        
        toolManager.activePage = page
        subviewManager.addPage = false
    }
    
    func getIndex() -> Int {
        var index = contentObject.note?.pages?.count ?? 1
        
        
        
        return index
    }
    
}
