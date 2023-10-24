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
            .sheet(isPresented: $manager.changePage, content: {
                TemplateView(
                    isPresented: $manager.changePage,
                    buttonTitle: "Ändern",
                    preselectedOrientation: toolManager.activePage!.isPortrait,
                    preselectedColor: toolManager.activePage!.color,
                    preselectedTemplate: toolManager.activePage!.template
                ) { isPortrait, template, color in
                    changePage(isPortrait, template, color)
                }
            })
            .sheet(isPresented: $manager.importFile, content: {
                
            })
            .sheet(isPresented: $manager.scanDocument, content: {
                
            })
            .sheet(isPresented: $manager.overview, content: {
                
            })
            .alert(
                "Möchtest du diese Seite wirklich löschen?",
                isPresented: $manager.deletePage
            ) {
                Button("Löschen", role: .destructive) {
                    deletePage()
                    subviewManager.deletePage = false
                }
                
                Button("Abbrechen", role: .cancel) {
                    subviewManager.deletePage = false
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
        withAnimation {
            toolManager.activePage = page
            subviewManager.addPage = false
        }
    }
    
    func changePage(_ portrait: Bool, _ template: String, _ color: String) {
        withAnimation(.bouncy) {
            toolManager.activePage?.isPortrait = portrait
            toolManager.activePage?.template = template
            toolManager.activePage?.color = color
        }
        
        subviewManager.changePage.toggle()
    }
    
    func deletePage() {
        withAnimation {
            if contentObject.note!.pages!.count - 1 == toolManager.activePage?.index {
                
                contentObject.note?.pages?.removeAll(where: {
                    $0.index == contentObject.note!.pages!.count - 1
                })
                
                toolManager.activePage = contentObject.note?.pages?.first(where: {
                    $0.index == contentObject.note!.pages!.count - 1
                })
                
            } else {
                guard let index = toolManager.activePage?.index else {
                    return
                }
                
                contentObject.note?.pages?.removeAll(where: {
                    $0.index == index
                })
                
                for page in contentObject.note!.pages! {
                    if index <= page.index {
                        page.index -= 1
                    }
                }
                
                toolManager.activePage = contentObject.note?.pages?
                    .first(where: { $0.index == index })
            }
        }
    }
    
    func getIndex() -> Int {
        guard let pages = contentObject.note?.pages else { return -1 }
        guard let index = toolManager.activePage?.index else { return -1 }
        
        for page in pages {
            if index < page.index {
                page.index += 1
            }
        }
        
        return index + 1
    }
    
}
