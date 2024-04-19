//
//  NoteSheetHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.11.22.
//

import SwiftUI

struct NoteViewSheet: ViewModifier {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    @Environment(PagingViewModel.self) var pvModel
    
    var contentObject: ContentObject
    var size: CGSize
    
    func body(content: Content) -> some View {
        @Bindable var manager = subviewManager
        
        content
            .modifier(MediaImport(contentObject: contentObject, size: size))
            .sheet(isPresented: $manager.overview, content: {
                OverviewContainerView(contentObject: contentObject)
            })
            .sheet(isPresented: $manager.addPage, content: {
                if let page = toolManager.activePage {
                    TemplateView(
                        isPresented: $manager.addPage,
                        buttonTitle: "Hinzufügen",
                        preselectedOrientation: page.isPortrait,
                        preselectedColor: page.color,
                        preselectedTemplate: page.template
                    ) { isPortrait, template, color in
                        addPage(isPortrait, template, color)
                    }
                } else {
                    ProgressView()
                }
            })
            .sheet(isPresented: $manager.showAI, content: {
                AIView()
                    .interactiveDismissDisabled()
            })
            .sheet(isPresented: $manager.changePage, content: {
                if let page = toolManager.activePage {
                    TemplateView(
                        isPresented: $manager.changePage,
                        buttonTitle: "Ändern",
                        preselectedOrientation: page.isPortrait,
                        preselectedColor: page.color,
                        preselectedTemplate: page.template
                    ) { isPortrait, template, color in
                        changePage(isPortrait, template, color)
                    }
                } else {
                    ProgressView()
                }
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
    }
}
