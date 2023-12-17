//
//  NoteSheetHelper.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.11.22.
//

import SwiftUI
import PencilKit
import PDFKit
import VisionKit

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
                
            })
            .sheet(isPresented: $manager.rtfEditor, content: {
                MDEditorViewContainer()
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
    
    func addPage(_ portrait: Bool, _ template: String, _ color: String) {
        let page: PPPageModel = PPPageModel(
            type: .template,
            index: getIndex()
        )
        
        page.isPortrait = portrait
        page.template = template
        page.color = color
        
        contentObject.note?.pages?.append(page)
        withAnimation {
            reader.scrollTo(page)
            toolManager.activePage = page
            subviewManager.addPage = false
        }
    }
    
    func changePage(_ p: Bool, _ t: String, _ c: String) {
        toolManager.activePage?.isPortrait = p
        toolManager.activePage?.template = t
        toolManager.activePage?.color = c
        
        subviewManager.changePage.toggle()
    }
    
    func scanDocument(with result: Result<VNDocumentCameraScan, any Error>) {
        toolManager.showProgress = true
        var selectedPage: PPPageModel?
        
        switch result {
        case .success(let scan):
            DispatchQueue.global(qos: .userInitiated).sync {
                guard let index = toolManager.activePage?.index else { return }
                for page in contentObject.note!.pages! {
                    if index < page.index {
                        page.index += scan.pageCount
                    }
                }
                
                for index in 0...scan.pageCount - 1 {
                    let scanPage = scan.imageOfPage(at: index)
                    let size = scanPage.size
                    
                    let page = PPPageModel(
                        type: .image,
                        index: toolManager.activePage!.index + 1 + index
                    )
                    
                    page.isPortrait = size.width < size.height
                    page.template = "blank"
                    page.color = "pagewhite"
                    
                    contentObject.note?.pages?.append(page)
                    page.media = scanPage.heicData()
                    
                    if selectedPage == nil {
                        selectedPage = page
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    toolManager.showProgress = false
                    
                    withAnimation {
                        reader.scrollTo(selectedPage)
                        toolManager.activePage = selectedPage
                    }
                }
            }
        case .failure:
            toolManager.showProgress = false
            break
        }
        
        subviewManager.scanDocument = false
    }
    
    func importPDF(with result: Result<[URL], any Error>) {
        toolManager.showProgress = true
        var selectedPage: PPPageModel?
        
        switch result {
        case .success(let urls):
            DispatchQueue.global(qos: .userInitiated).sync {
                guard let url = urls.first else { return }
                
                if url.startAccessingSecurityScopedResource() {
                    guard let pdf = PDFDocument(url: url) else { return }
                    defer { url.stopAccessingSecurityScopedResource() }
                    
                    guard let index = toolManager.activePage?.index else { return }
                    for page in contentObject.note!.pages! {
                        if index < page.index {
                            page.index += pdf.pageCount
                        }
                    }
                    
                    for index in 0...pdf.pageCount - 1 {
                        
                        guard let page = pdf.page(at: index) else { return }
                        guard let data = page.dataRepresentation else { return }
                        
                        let size = page.bounds(for: .mediaBox).size
                        let title: String = page.string?.components(
                            separatedBy: .newlines
                        ).first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                        
                        let ppPage = PPPageModel(
                            type: .pdf,
                            index: toolManager.activePage!.index + 1 + index
                        )
                        
                        ppPage.media = data
                        ppPage.title = title
                        
                        ppPage.isPortrait = size.width < size.height
                        ppPage.template = "blank"
                        ppPage.color = "pagewhite"
                        contentObject.note?.pages?.append(ppPage)
                        
                        if selectedPage == nil {
                            selectedPage = ppPage
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    toolManager.showProgress = false
                    
                    withAnimation {
                        reader.scrollTo(selectedPage)
                        toolManager.activePage = selectedPage
                    }
                }
            }
        case .failure:
            toolManager.showProgress = false
            break
        }
        
        subviewManager.importFile = false
    }
    
    func deletePage() {
        Task { @MainActor in
            withAnimation {
                if contentObject.note!.pages!.count - 1 == toolManager.activePage?.index {
                    
                    contentObject.note?.pages?.removeAll(where: {
                        $0.index == contentObject.note!.pages!.count - 1
                    })
                    
                    let page = contentObject.note?.pages?.first(where: {
                        $0.index == contentObject.note!.pages!.count - 1
                    })
                    
                    reader.scrollTo(page)
                    toolManager.activePage = page
                    
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
                    
                    let page = contentObject.note?.pages?
                        .first(where: { $0.index == index })
                    
                    reader.scrollTo(page)
                    toolManager.activePage = page
                }
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
