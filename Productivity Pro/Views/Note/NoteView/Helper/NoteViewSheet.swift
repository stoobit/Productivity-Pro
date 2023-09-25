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
    @Binding var document: Document
    @Binding var url: URL
    
    @Bindable var subviewManager: SubviewManager
    @Bindable var toolManager: ToolManager
    
    @State var isPortrait: Bool = false
    @State var selectedColor: String = ""
    @State var selectedTemplate: String = ""
    
    let proxy: GeometryProxy
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $subviewManager.changeTemplate) {
                ChangePageTemplateView(
                    document: $document,
                    isPresented: $subviewManager.changeTemplate,
                    toolManager: toolManager
                )
            }
            .sheet(isPresented: $subviewManager.showTextEditor) {
                EditMarkdownView(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager,
                    size: proxy.size
                )
                .edgesIgnoringSafeArea(.all)
            }
            .sheet(
                isPresented: $subviewManager.addPageSettingsSheet,
                onDismiss: { undoManager?.removeAllActions() }
            ) {
                
                let page = document.note.pages[toolManager.selectedPage]
                
                TemplateView(
                    isPresented: $subviewManager.addPageSettingsSheet, 
                    isPortrait: $isPortrait,
                    selectedColor: $selectedColor,
                    selectedTemplate: $selectedTemplate,
                    buttonTitle: "Hinzufügen", 
                    preselectedOrientation: page.isPortrait,
                    preselectedColor: page.backgroundColor,
                    preselectedTemplate: page.backgroundTemplate,
                    action: addPage
                )
            }
            .sheet(isPresented: $subviewManager.overviewSheet) {
                OverviewView(
                    document: $document,
                    toolManager: toolManager,
                    subviewManager: subviewManager
                )
            }
            .sheet(isPresented: $subviewManager.sharePDFSheet) {
                ShareSheet(
                    showProgress: $toolManager.showProgress,
                    subviewManager: subviewManager,
                    toolManager: toolManager,
                    document: $document,
                    type: .pdf
                )
            }
            .background {
                if subviewManager.showPrinterView {
                    if let url = toolManager.pdfRendering {
                        PrinterView(
                            document: $document,
                            subviewManager: subviewManager,
                            url: url
                        )
                    }
                }
            }
            .fileMover(isPresented: $subviewManager.moveView, file: url) { result in
                switch result {
                case .success(let success):
                       
                    url = success
                    
                case .failure: break
                    
                }
            }
    }
    
    func addPage() {
        
        let newPage = Page(
            canvasType: .pencilKit,
            backgroundColor: selectedColor,
            backgroundTemplate: selectedTemplate,
            isPortrait: isPortrait
        )
        
        toolManager.preloadedMedia.insert(
            nil, at: toolManager.selectedPage + 1
        )
        
        document.note.pages.insert(
            newPage, at: toolManager.selectedPage + 1
        )

        subviewManager.addPageSettingsSheet = false
        toolManager.selectedPage += 1
    }
}