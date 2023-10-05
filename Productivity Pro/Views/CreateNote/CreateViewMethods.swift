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
