//
//  NoteSheetHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.11.22.
//

import SwiftUI

struct NoteViewSheet: ViewModifier {
    @Environment(\.undoManager) var undoManager
    
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    var contentObject: ContentObject
    var reader: ScrollViewProxy
    
    func body(content: Content) -> some View {
        @Bindable var manager = subviewManager
        
        content
            .sheet(isPresented: $manager.addPage, content: {
                TemplateView(
                    isPresented: $manager.addPage,
                    buttonTitle: "Hinzufügen",
                    preselectedOrientation: toolManager.activePage!.isPortrait,
                    preselectedColor: toolManager.activePage!.color,
                    preselectedTemplate: toolManager.activePage!.template
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
            .sheet(isPresented: $manager.overview, content: {
                OverviewContainerView(contentObject: contentObject)
            })
            .sheet(isPresented: $manager.rtfEditor, content: {
                MDEditorView()
            })
            .fullScreenCover(isPresented: $manager.scanDocument) {
                ScannerView(
                    cancelAction: { subviewManager.scanDocument = false }
                ) { result in
                    scanDocument(with: result)
                }
                .edgesIgnoringSafeArea(.all)
            }
            .fileImporter(
                isPresented: $manager.importFile,
                allowedContentTypes: [.pdf],
                allowsMultipleSelection: false
            ) { result in
                importPDF(with: result)
            }
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
            .background {
                if subviewManager.printerView {
//                    PrinterView(
//                        document: $document,
//                        subviewManager: subviewManager,
//                        url: url
//                    )
                }
            }
    }
}
