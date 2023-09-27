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
    
    func importFolder(with result: Result<[URL], any Error>) {
        switch result {
        case .success(let urls):
            
            if let document = urls.first {
                url = document
                folderPicker.toggle()
            } else {
                isFailure.toggle()
            }
            
        case .failure:
            isFailure.toggle()
        }
    }
    func createTemplate() {
        document.documentType = .note
        
        let canvasType: CanvasType = .pencilKit
        
        var note = Note()
        let firstPage: Page = Page(
            canvasType: canvasType,
            backgroundColor: selectedColor,
            backgroundTemplate: selectedTemplate,
            isPortrait: isPortrait
        )
        
        toolManager.preloadedMedia.append(nil)
        note.pages.append(firstPage)
        document.note = note
        
        do {
            if url.startAccessingSecurityScopedResource() {
                let data = try JSONEncoder().encode(document)
                let encryptedData = data.base64EncodedData()
                
                if title == "" {
                    title = "Unbenannt"
                }
                
                url.appendPathComponent("\(title)", conformingTo: .pro)
                
                var ver = 1
                while FileManager.default.fileExists(atPath: url.path) {
                    url.deleteLastPathComponent()
                    url.appendPathComponent("\(title) \(ver)", conformingTo: .pro)
                    
                    ver += 1
                }
                
                try encryptedData.write(to: url, options: .noFileProtection)
                url.deletingLastPathComponent().stopAccessingSecurityScopedResource()
            }
            
        } catch {
            print(error)
        }
        
        
        savedBackgroundColor = selectedColor
        savedBackgroundTemplate = selectedTemplate
        savedIsPortrait = isPortrait
        
        templatePicker.toggle()
        isPresented.toggle()
    }
    func createFromLastSelection() {
        document.documentType = .note
        
        let canvasType: CanvasType = .pencilKit
        
        var note = Note()
        let firstPage: Page = Page(
            canvasType: canvasType,
            backgroundColor: savedBackgroundColor,
            backgroundTemplate: savedBackgroundTemplate,
            isPortrait: savedIsPortrait
        )
        
        toolManager.preloadedMedia.append(nil)
        note.pages.append(firstPage)
        document.note = note
        
        do {
            if url.startAccessingSecurityScopedResource() {
                let data = try JSONEncoder().encode(document)
                let encryptedData = data.base64EncodedData()
                
                if title == "" {
                    title = "Unbenannt"
                }
                
                url.appendPathComponent("\(title)", conformingTo: .pro)
                
                var ver = 1
                while FileManager.default.fileExists(atPath: url.path) {
                    url.deleteLastPathComponent()
                    url.appendPathComponent("\(title) \(ver)", conformingTo: .pro)
                    
                    ver += 1
                }
                
                try encryptedData.write(to: url, options: .noFileProtection)
                url.deletingLastPathComponent().stopAccessingSecurityScopedResource()
            }
            
        } catch {
            print(error)
        }
        
        isPresented.toggle()
    }
    func createPDF(with result: Result<[URL], any Error>) {
        var pdf = PDFDocument()
        
        switch result {
        case .success(let urls):
            
            if let pdfURL = urls.first {
                if let pdfDocument = PDFDocument(url: pdfURL) {
                    pdf = pdfDocument
                    
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
                        
                        let canvasType: CanvasType = .pencilKit
                        
                        let newPage = Page(
                            type: .pdf,
                            canvasType: canvasType,
                            backgroundMedia: data,
                            header: header,
                            backgroundColor: "pagewhite",
                            backgroundTemplate: "blank",
                            isPortrait: size.width < size.height
                        )
                        
                        if let data = page.dataRepresentation {
                            toolManager.preloadedMedia.append(PDFDocument(data: data))
                        } else {
                            toolManager.preloadedMedia.append(nil)
                        }
                        
                        document.note.pages.append(newPage)
                    }
                    
                    do {
                        if url.startAccessingSecurityScopedResource() {
                            let data = try JSONEncoder().encode(document)
                            let encryptedData = data.base64EncodedData()
                            
                            if title == "" {
                                title = "Unbenannt"
                            }
                            
                            url.appendPathComponent("\(title)", conformingTo: .pro)
                            
                            var ver = 1
                            while FileManager.default.fileExists(atPath: url.path) {
                                url.deleteLastPathComponent()
                                url.appendPathComponent("\(title) \(ver)", conformingTo: .pro)
                                
                                ver += 1
                            }
                            
                            try encryptedData.write(to: url, options: .noFileProtection)
                            url.deletingLastPathComponent().stopAccessingSecurityScopedResource()
                        }
                        
                    } catch {
                        print(error)
                    }
                    
                    isPresented.toggle()
                }
            } else {
                isFailure.toggle()
            }
            
        case .failure:
            isFailure.toggle()
        }
    }
    
    func add(scan: VNDocumentCameraScan) {
        toolManager.showProgress = true
        
        subviewManager.newDocScan = false
        subviewManager.showAddFile = false
        
        document.note = Note()
        document.documentType = .note
        
        for index in 0...scan.pageCount - 1 {
            
            let page = scan.imageOfPage(at: index)
            let size = page.size
            
            let canvasType: CanvasType = .pencilKit
            
            let newPage = Page(
                type: .image,
                canvasType: canvasType,
                backgroundMedia: page.heicData(),
                backgroundColor: "pagewhite",
                backgroundTemplate: "blank",
                isPortrait: size.width < size.height
            )
            
            toolManager.preloadedMedia.append(nil)
            document.note.pages.append(newPage)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            toolManager.showProgress = false
        }
    }
    
}
