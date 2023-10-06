//
//  CreateViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI
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
            
            let page = PPPageModel(type: .template, canvas: .pkCanvas)
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
            
            let page = PPPageModel(type: .template, canvas: .pkCanvas)
            page.note = note
            page.isPortrait = isPortrait
            page.template = template
            page.color = color
            
            isPresented.toggle()
        }
    }
    
    func importedPDF(with result: Result<[URL], any Error>) {
        
    }
    
    func scannedDocument(with result: Result<VNDocumentCameraScan, any Error>) {
        switch result {
        case .success(let scan):
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
                
                for index in 0...scan.pageCount - 1 {
                    let scanPage = scan.imageOfPage(at: index)
                    let size = scanPage.size
                    
                    let page = PPPageModel(type: .image, canvas: .pkCanvas)
                    page.note = note
                    
                    page.isPortrait = size.width < size.height
                    page.template = "blank"
                    page.color = "pagewhite"
                    
                    page.media = scanPage.heicData()
                }
            }
        case .failure:
            break
        }
        
        isPresented = false
    }
    
    func getTitle() -> String {
        var title: String = "Unbenannt"
        var index: Int = 1
        
        let filteredObjects = contentObjects
            .filter({
                $0.type == .file &&
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
