//
//  PDFManager.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.01.24.
//

import PDFKit
import PencilKit
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
            
            let view = ZStack {
                PageView(
                    note: note, page: page,
                    scale: .constant(1), offset: .constant(.zero),
                    preloadModels: true
                )
                
                Image(uiImage: renderCanvas(page: page))
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: getFrame(page: page).width,
                        height: getFrame(page: page).height
                    )
            }
            .environment(ToolManager())
            .environment(SubviewManager())
            
            let renderer = ImageRenderer(content: view)
           
            renderer.render { _, context in
                context(pdf)
            }
           
            pdf.endPDFPage()
        }
        
        pdf.closePDF()
        return url
    }
    
    func renderCanvas(page: PPPageModel) -> UIImage {
        var image = UIImage()
        
        UITraitCollection(userInterfaceStyle: colorScheme(page: page)).performAsCurrent {
            try? image = PKDrawing(data: page.canvas).image(
                from: CGRect(
                    x: 0,
                    y: 0,
                    width: getFrame(page: page).width,
                    height: getFrame(page: page).height
                ),
                scale: 5
            )
        }
        
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
    
    private func colorScheme(page: PPPageModel) -> UIUserInterfaceStyle {
        var cs: UIUserInterfaceStyle = .dark
        
        if page.color == "pagewhite" || page.color == "white" || page.color == "pageyellow" || page.color == "yellow" {
            cs = .light
        }
        
        return cs
    }
}
