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
            
            let page = PPPageModel(type: .template, index: 0)
            page.note = note
            page.isPortrait = savedIsPortrait
            page.template = savedBackgroundTemplate
            page.color = savedBackgroundColor
        }
    }
    
    func selectedTemplate(
        _ isPortrait: Bool, _ template: String, _ color: String,
        _ title: String?
    ) {
        withAnimation(.bouncy) {
            let title = title == nil ? getTitle() : title!
            
            let object = ContentObject(
                id: UUID(),
                title: title,
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
            
            selectTemplate.toggle()
        }
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
        
        scanDocument = false
    }
    
    func getTitle() -> String {
        var title = String(localized: "Unbenannt")
        var index = 1
        
        let filteredObjects = contentObjects
            .filter {
                $0.type == COType.file.rawValue &&
                    $0.parent == parent &&
                    $0.grade == grade &&
                    $0.inTrash == false
            }
            .map { $0.title }
        
        while filteredObjects.contains(title) {
            title = String(localized: "Unbenannt \(index)")
            index += 1
        }
        
        return title
    }
}
