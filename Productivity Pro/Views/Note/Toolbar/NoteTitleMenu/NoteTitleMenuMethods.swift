//
//  NoteTitleMenuMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.09.23.
//

import SwiftUI
import PencilKit

extension NoteTitleMenu {
    
    func togglePin() {
        if pinned.contains(url) {
            pinned.removeAll(where: { $0 == url })
        } else {
            pinned.insert(url, at: 0)
        }
    }
    
    func sharePDF() {
        toolManager.showProgress = true
        toolManager.selectedItem = nil
        
        Task(priority: .userInitiated) {
            await MainActor.run {
                toolManager.pdfRendering = renderPDF()
            }
            
            toolManager.showProgress = false
            subviewManager.sharePDFSheet.toggle()
        }
    }
    
    func print() {
        toolManager.showProgress = true
        toolManager.selectedItem = nil
        
        Task(priority: .userInitiated) {
            await MainActor.run {
                toolManager.pdfRendering = renderPDF()
            }
            
            toolManager.showProgress = false
            subviewManager.showPrinterView.toggle()
        }
    }
    
    @MainActor func renderPDF() -> URL {
        
        let name: String = url.deletingPathExtension().lastPathComponent
        
        let url = URL.documentsDirectory.appending(
            path: "\(name).pdf"
        )
        
        guard let pdf = CGContext(url as CFURL, mediaBox: nil, nil) else {
            return url
        }
        
        let tm = ToolManager()
        tm.scrollOffset = CGPoint(x: 0, y: 0)
        tm.zoomScale = 1
        
        for page in document.note.pages {
            
            let renderedCanvas = renderCanvas(page: page)
            var box = CGRect(
                x: 0,
                y: 0,
                width: getFrame(page: page).width,
                height: getFrame(page: page).height
            )
            
            pdf.beginPage(mediaBox: &box)
            
            var view: some View {
                ZStack {
                    
                    PageView(
                        document: $document,
                        page: .constant(page),
                        offset: .constant(0),
                        toolManager: tm,
                        subviewManager: subviewManager,
                        drawingModel: PPDrawingModel(),
                        pdfRendering: true,
                        highRes: true,
                        size: getFrame(page: page)
                    )
                    
                    Image(uiImage: renderedCanvas)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: getFrame(page: page).width,
                            height: getFrame(page: page).height
                        )
                    
                }
                .frame(
                    width: getFrame(page: page).width,
                    height: getFrame(page: page).height
                )
            }
            
            let renderer = ImageRenderer(content: view)
            
            renderer.render { size, context in
                context(pdf)
            }
            
            pdf.endPDFPage()
            
        }
        
        pdf.closePDF()
        
        
        return url
    }
    
    func renderCanvas(page: Page) -> UIImage {
        var image: UIImage = UIImage()
        
        UITraitCollection(
            userInterfaceStyle: colorScheme(page: page)
        ).performAsCurrent {
            
            try? image = PKDrawing(data: page.canvas).image(
                from: CGRect(
                    x: 0,
                    y: 0,
                    width: getFrame(page: page).width,
                    height: getFrame(page: page).height
                ),
                scale: 70
            )
        }
        
        return image
    }
    
    func getFrame(page: Page) -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
    func colorScheme(page: Page) -> UIUserInterfaceStyle {
        var cs: UIUserInterfaceStyle = .dark
        
        if  page.backgroundColor == "pagewhite" ||  page.backgroundColor == "white" ||  page.backgroundColor == "pageyellow" ||  page.backgroundColor == "yellow"{
            cs = .light
        }
        
        return cs
    }
}
