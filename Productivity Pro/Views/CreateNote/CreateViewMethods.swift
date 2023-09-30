//
//  CreateViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI

extension CreateNoteView {
    
    func lastTemplate() {
        
    }
    
    func selectedTemplate(
        _ isPortrait: Bool, _ template: String, _ color: String
    ) {
        let object = ContentObject(
            id: UUID(),
            title: "",
            type: .file,
            parent: parent,
            created: Date(),
            grade: grade
        )
       
        context.insert(object)
        
        let note = PPNoteModel(type: .standard)
        object.note = note
        
        let page = PPPageModel(type: .template, canvas: .pkCanvas)
        page.note = note
        page.isPortrait = isPortrait
        page.template = template
        page.color = color
        
        selectTemplate.toggle()
        isPresented.toggle()
    }
    
    func importedPDF() {
        
    }
    
    func scannedDocument() {
        
    }
    
}
