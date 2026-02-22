//
//  NoteViewModalMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 03.01.24.
//

import PDFKit
import SwiftUI
import VisionKit

extension NoteViewSheet {
    func addPage(_ portrait: Bool, _ template: String, _ color: String) {
        let page = PPPageModel(
            type: .template,
            index: getIndex()
        )
        
        page.isPortrait = portrait
        page.template = template
        page.color = color
        
        contentObject.note?.pages?.append(page)
        
        withAnimation(.smooth(duration: 0.2)) {
            toolManager.activePage = page
            pvModel.index += 1
        }
        
        subviewManager.addPage = false
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
                guard let index = toolManager.activePage?.index else {
                    return
                }
                
                for page in contentObject.note!.pages! {
                    if index < page.index {
                        page.index += scan.pageCount
                    }
                }
                
                for index in 0...scan.pageCount - 1 {
                    let scanPage = scan.imageOfPage(at: index)
                    let size = scanPage.size
                    
                    guard let i = toolManager.activePage?.index else {
                        return
                    }
                    
                    let page = PPPageModel(
                        type: .image,
                        index: i + 1 + index
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
                    
                    withAnimation(.smooth(duration: 0.2)) {
                        if let selectedPage = selectedPage {
                            toolManager.activePage = selectedPage
                        }
                        
                        pvModel.index += 1
                    }
                }
            }
        case .failure:
            toolManager.showProgress = false
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
                    
                    guard let index = toolManager.activePage?.index else {
                        return
                    }
                    
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
                        
                        guard let i = toolManager.activePage?.index else {
                            return
                        }
                        
                        let ppPage = PPPageModel(
                            type: .pdf,
                            index: i + 1 + index
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
                    
                    withAnimation(.smooth(duration: 0.2)) {
                        if let selectedPage = selectedPage {
                            toolManager.activePage = selectedPage
                        }
                        
                        pvModel.index += 1
                    }
                }
            }
        case .failure:
            toolManager.showProgress = false
        }
        
        subviewManager.importFile = false
    }
    
    func deletePage() {
        Task { @MainActor in
        
            if contentObject.note!.pages!.count - 1 == toolManager.activePage?.index {
                contentObject.note?.pages?.removeAll(where: {
                    $0.index == contentObject.note!.pages!.count - 1
                })
                    
                let page = contentObject.note!.pages!.first(where: {
                    $0.index == contentObject.note!.pages!.count - 1
                })!
                    
                toolManager.activePage = page
                pvModel.index = page.index
                    
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
                    
                let page = contentObject.note!.pages!
                    .first(where: { $0.index == index })!
                    
                toolManager.activePage = page
                pvModel.index = page.index
            }
        }
    }
    
    func getIndex() -> Int {
        guard let pages = contentObject.note?.pages else { return -1 }
        guard let index = toolManager.activePage?.index else {
            return -1
        }
        
        for page in pages {
            if index < page.index {
                page.index += 1
            }
        }
        
        return index + 1
    }
}
