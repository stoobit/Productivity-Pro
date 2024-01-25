//
//  PDFManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.01.24.
//

import PDFKit
import SwiftUI

struct PDFManager {
    @MainActor
    func exportPDF(from contentObject: ContentObject) throws -> URL {
        var url = URL.documentsDirectory
        url.append(path: "\(contentObject.title).pdf")
        
        guard let note = contentObject.note else { throw RuntimeError("Note is empty.") }
        guard var pages = note.pages else { throw RuntimeError("Pages are empty.") }
        pages.sort(using: SortDescriptor(\.index))
        
        guard let pdf = CGContext(url as CFURL, mediaBox: nil, nil) else {
            return url
        }
        
        for page in pages {
            var frame = CGRect(origin: .zero, size: getFrame(page: page))
            pdf.beginPage(mediaBox: &frame)
            
            let view = PageView(
                note: note,
                page: page,
                scale: .constant(1),
                offset: .constant(.zero),
                size: getFrame(page: page),
                preloadModels: true,
                realrenderText: true
            )
            .environment(ToolManager())
            .environment(SubviewManager())
            
            let renderer = ImageRenderer(content: view)
           
            renderer.render { _, context in
                context(pdf)
            }
           
            pdf.endPDFPage()
        }
        pdf.closePDF()
        
//        if url.startAccessingSecurityScopedResource() {
//            guard let pdfDocument = PDFDocument(url: url) else { return url }
//            defer { url.stopAccessingSecurityScopedResource() }
//            
//            for index in 0 ... pages.count - 1 {
//                guard let page = pdfDocument.page(at: 0) else { return url }
//                
//                let annotation = PDFAnnotation()
//                annotation.border = PDFBorder()
//                annotation.border?.lineWidth = 100
//            }
//            
//            pdfDocument.write(to: url)
//        }
        
        return url
    }
    
//    @MainActor func renderPDF() -> URL {
//        let name: String = URL.desktopDirectory.deletingPathExtension().lastPathComponent
//
//        let url = URL.documentsDirectory.appending(
//            path: "\(name).pdf"
//        )
//
//        guard let pdf = CGContext(url as CFURL, mediaBox: nil, nil) else {
//            return url
//        }
//
//        let tm = ToolManager()
//        tm.scrollOffset = CGPoint(x: 0, y: 0)
//
    ////        for page in document.note.pages {
    ////
    ////            let renderedCanvas = renderCanvas(page: page)
    ////            var box = CGRect(
    ////                x: 0,
    ////                y: 0,
    ////                width: getFrame(page: page).width,
    ////                height: getFrame(page: page).height
    ////            )
    ////
    ////            pdf.beginPage(mediaBox: &box)
    ////
    ////            var view: some View {
    ////                ZStack {
    ////
    ////                    PageView(
    ////                        document: $document,
    ////                        page: .constant(page),
    ////                        offset: .constant(0),
    ////                        toolManager: tm,
    ////                        subviewManager: subviewManager,
    ////                        drawingModel: PPDrawingModel(),
    ////                        pdfRendering: true,
    ////                        highRes: true,
    ////                        size: getFrame(page: page)
    ////                    )
    ////
    ////                    Image(uiImage: renderedCanvas)
    ////                        .resizable()
    ////                        .scaledToFit()
    ////                        .frame(
    ////                            width: getFrame(page: page).width,
    ////                            height: getFrame(page: page).height
    ////                        )
    ////
    ////                }
    ////                .frame(
    ////                    width: getFrame(page: page).width,
    ////                    height: getFrame(page: page).height
    ////                )
    ////            }
    ////
    ////            let renderer = ImageRenderer(content: view)
    ////
    ////            renderer.render { size, context in
    ////                context(pdf)
    ////            }
    ////
    ////            pdf.endPDFPage()
    ////
    ////        }
//
//        pdf.closePDF()
//
//        return url
//    }
    
    func renderCanvas(page: Page) -> UIImage {
        var image = UIImage()
//
//        UITraitCollection(
//            userInterfaceStyle: colorScheme(page: page)
//        ).performAsCurrent {
//            try? image = PKDrawing(data: page.canvas).image(
//                from: CGRect(
//                    x: 0,
//                    y: 0,
//                    width: getFrame(page: page).width,
//                    height: getFrame(page: page).height
//                ),
//                scale: 70
//            )
//        }
        
        return image
    }
    
    private func getFrame(page: PPPageModel) -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
    private func colorScheme(page: Page) -> UIUserInterfaceStyle {
        var cs: UIUserInterfaceStyle = .dark
        
        if page.backgroundColor == "pagewhite" || page.backgroundColor == "white" || page.backgroundColor == "pageyellow" || page.backgroundColor == "yellow" {
            cs = .light
        }
        
        return cs
    }
}
