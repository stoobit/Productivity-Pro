//
//  CreateViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI
import PDFKit
import VisionKit

extension CreateNoteView {
    
    func lastTemplate() {
        withAnimation(.bouncy) {
            let object = ContentObject(
                id: UUID(),
                title: getTitle(),
                type: .file,
                parent: parent,
                created: Date(),
                grade: grade
            )
            
            context.insert(object)
            
            let note = PPNoteModel()
            object.note = note
            
            let page = PPPageModel(type: .template, index: 0)
            page.note = note
            page.isPortrait = savedIsPortrait
            page.template = savedBackgroundTemplate
            page.color = savedBackgroundColor
            
            isPresented.toggle()
        }
    }
    
    func selectedTemplate(
        _ isPortrait: Bool, _ template: String, _ color: String
    ) {
        withAnimation(.bouncy) {
            let object = ContentObject(
                id: UUID(),
                title: getTitle(),
                type: .file,
                parent: parent,
                created: Date(),
                grade: grade
            )
            
            context.insert(object)
            
            let note = PPNoteModel()
            object.note = note
            
            let page = PPPageModel(type: .template, index: 0)
            
            page.note = note
            page.isPortrait = isPortrait
            page.template = template
            page.color = color
            
            isPresented.toggle()
        }
    }
    
    func importedPDF(with result: Result<[URL], any Error>) {
        toolManager.showProgress = true
        
        withAnimation(.bouncy) {
            switch result {
            case .success(let urls):
                DispatchQueue.global(qos: .userInitiated).sync {
                    guard let url = urls.first else { return }
                    
                    if url.startAccessingSecurityScopedResource() {
                        guard let pdf = PDFDocument(url: url) else { return }
                        defer { url.stopAccessingSecurityScopedResource() }
                        
                        let object = ContentObject(
                            id: UUID(),
                            title: getTitle(),
                            type: .file,
                            parent: parent,
                            created: Date(),
                            grade: grade
                        )
                        
                        context.insert(object)
                        
                        let note = PPNoteModel()
                        object.note = note
                        
                        for index in 0...pdf.pageCount - 1 {
                            
                            guard let page = pdf.page(at: index) else { return }
                            guard let data = page.dataRepresentation else { return }
                            
                            let size = page.bounds(for: .mediaBox).size
                            let title: String = page.string?.components(
                                separatedBy: .newlines
                            ).first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                            
                            let ppPage = PPPageModel(
                                type: .pdf, index: index
                            )
                            
                            ppPage.note = note
                            ppPage.media = data
                            ppPage.title = title
                            
                            ppPage.isPortrait = size.width < size.height
                            ppPage.template = "blank"
                            ppPage.color = "pagewhite"
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            toolManager.showProgress = false
                        }
                    }
                }
                
            case .failure:
                break
            }
        }
        
        isPresented = false
    }
    
    func scannedDocument(with result: Result<VNDocumentCameraScan, any Error>) {
        toolManager.showProgress = true
        
        withAnimation(.bouncy) {
            switch result {
            case .success(let scan):
                DispatchQueue.global(qos: .userInitiated).sync {
                    let object = ContentObject(
                        id: UUID(),
                        title: getTitle(),
                        type: .file,
                        parent: parent,
                        created: Date(),
                        grade: grade
                    )
                    
                    context.insert(object)
                    
                    let note = PPNoteModel()
                    object.note = note
                    
                    for index in 0...scan.pageCount - 1 {
                        let scanPage = scan.imageOfPage(at: index)
                        let size = scanPage.size
                        let page = PPPageModel(type: .image, index: index)
                        
                        page.note = note
                        
                        page.isPortrait = size.width < size.height
                        page.template = "blank"
                        page.color = "pagewhite"
                        
                        page.media = scanPage.heicData()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        toolManager.showProgress = false
                    }
                }
            case .failure:
                break
            }
        }
        
        isPresented = false
    }
    
    func getTitle() -> String {
        var title: String = "Unbenannt"
        var index: Int = 1
        
        let filteredObjects = contentObjects
            .filter({
                $0.type == COType.file.rawValue &&
                $0.parent == parent &&
                $0.grade == grade &&
                $0.inTrash == false
            })
            .map({ $0.title })
        
        
        while filteredObjects.contains(title) {
            
            title = "Unbenannt \(index)"
            index += 1
            
        }
        
        return title
    }
    
}
