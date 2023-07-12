//
//  NewDocumentMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.07.23.
//

import SwiftUI
import VisionKit
import PDFKit

extension NewDocumentView {
    
    func getDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()

        // Set Date/Time Style
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

       
        return dateFormatter.string(from: date) 
    }
    
    func add(pdf: PDFDocument) {
        document.note = Note()
        document.documentType = .note
        
        for index in 0...pdf.pageCount - 1 {
            
            guard let page = pdf.page(at: index) else { return }
            let size = page.bounds(for: .mediaBox).size
            
            var data: Data?
            var header: String?
            
            data = page.dataRepresentation
            header = page.string?.components(separatedBy: .newlines).first
            header = header?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let newPage = Page(
                type: .pdf,
                backgroundMedia: data,
                header: header,
                backgroundColor: "pagewhite",
                backgroundTemplate: "blank",
                isPortrait: size.width < size.height
            )
           
            document.note.pages.append(newPage)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            toolManager.showProgress = false
        }
    }
    
    func add(scan: VNDocumentCameraScan) {
        toolManager.showProgress = true
        
        subviewManager.newDocScan = false
        subviewManager.createDocument = false
        
        document.note = Note()
        document.documentType = .note
        
        for index in 0...scan.pageCount - 1 {
            
            let page = scan.imageOfPage(at: index)
            let size = page.size
            
            let newPage = Page(
                type: .image,
                backgroundMedia: page.jpegData(
                    compressionQuality: 0.8
                ),
                backgroundColor: "pagewhite",
                backgroundTemplate: "blank",
                isPortrait: size.width < size.height
            )
            
            document.note.pages.append(newPage)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            toolManager.showProgress = false
        }
    }
    
    func createBlank() {
        document.documentType = .note
        
        var note = Note()
        let firstPage: Page = Page(
            backgroundColor: "pagewhite",
            backgroundTemplate: "blank",
            isPortrait: true
        )
        
        note.pages.append(firstPage)
        document.note = note
        
        subviewManager.newDocTemplate = false
    }
    
}
