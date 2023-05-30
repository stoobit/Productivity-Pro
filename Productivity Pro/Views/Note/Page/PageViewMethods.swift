//
//  PageViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.03.23.
//

import SwiftUI
import PencilKit
import PDFKit

extension PageView {
    
    func renderPDF() {
        let page: PDFPage = (PDFDocument(
            data: page.backgroundMedia!
        )?.page(at: 0))!
        
        let factor = isOverview ? 0.5 : toolManager.zoomScale * 6
        let image: UIImage = page.thumbnail(
            of: page.bounds(for: .mediaBox).size * factor,
            for: .mediaBox
        )
        
        renderedBackground = image
    }
    
    func colorScheme() -> UIUserInterfaceStyle {
        var cs: UIUserInterfaceStyle = .dark
        
        if page.backgroundColor == "yellow" || page.backgroundColor == "white" {
            cs = .light
        }
        
        return cs
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
    func onBackgroundTap() {
        if toolManager.dragType == .none {
            toolManager.selectedItem = nil
            toolManager.dragType = .none
            toolManager.isEditorVisible = true
        }
    }
    
    func addTextField(text: String) {
        var newItem = ItemModel(
            width: 600,
            height: 300,
            type: .textField
        )
        
        newItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + newItem.width/2 + 40
        
        newItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + newItem.height/2 + 40
        
        let textField = TextFieldModel(
            text: text,
            font: defaultFont,
            fontSize: defaultFontSize,
            fontColor: getNIColor()
        )
        
        newItem.textField = textField
        
        document.document.note.pages[
            toolManager.selectedPage
        ].items.append(newItem)
        toolManager.selectedItem = newItem
    }
    
    func addImage(img: UIImage) {
        
            let image = resize(img, to: CGSize(width: 1024, height: 1024))
            let ratio = 400/image.size.width
            
            var newItem = ItemModel(
                width: image.size.width * ratio,
                height: image.size.height * ratio,
                type: .media
            )
            
            newItem.x = toolManager.scrollOffset.size.width * (1/toolManager.zoomScale) + newItem.width/2 + 40
            
            newItem.y = toolManager.scrollOffset.size.height * (1/toolManager.zoomScale) + newItem.height/2 + 40
            
            let media = MediaModel(media: image.pngData() ?? Data())
            newItem.media = media
            
            document.document.note.pages[
                toolManager.selectedPage
            ].items.append(newItem)
            toolManager.selectedItem = newItem
    }
    
    func getNIColor() -> Data {
        
#if targetEnvironment(macCatalyst)
        var color: Color = Color(.displayP3, red: 2/255, green: 2/255, blue: 2/255)
#else
        var color: Color = .black
#endif
        
        let page = document.document.note.pages[toolManager.selectedPage]
        
        if page.backgroundColor == "black" || page.backgroundColor == "gray" {
            color = .white
        }
        
        return color.toCodable()
    }
    
}
