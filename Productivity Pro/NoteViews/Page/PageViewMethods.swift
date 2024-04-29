//
//  PageViewMethods.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.03.23.
//

import PDFKit
import PencilKit
import SwiftUI

extension PageView {
    func colorScheme() -> UIUserInterfaceStyle {
        var cs: UIUserInterfaceStyle = .dark
        
        if page.color == "pagewhite" || page.color == "white" || page.color == "pageyellow" || page.color == "yellow" {
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
        if toolManager.dragType == .none, subviewManager.showInspector == false {
            toolManager.activeItem = nil
            toolManager.dragType = .none
            toolManager.editorVisible = true
        }
    }
    
    func add(string: String) {
        toolManager.pencilKit = false
        
        let item = PPItemModel(index: 0, type: .textField)
        item.width = 600
        item.height = 300
        
        let size = Pos.calculate(model: toolManager, item: item, size: size)
        item.x = size.x
        item.y = size.y
        
        let textField = PPTextFieldModel(
            textColor: primaryColor(),
            font: defaultFont,
            fontSize: defaultFontSize
        )
      
        textField.string = string
        item.textField = textField
        
        let page = toolManager.activePage
        item.index = page?.items?.count ?? 0
        page?.items?.append(item)
        
        page?.store(item, type: .create) {
            item
        }
        
        toolManager.activeItem = item
    }
    
    @MainActor func add(image: Image) {
        let selectedImage = image.asUIImage()
        
        let image = resize(selectedImage, to: CGSize(width: 2048, height: 2048))
        let ratio = 400 / image.size.width
        
        let item = PPItemModel(index: 0, type: .media)
        item.width = image.size.width * ratio
        item.height = image.size.height * ratio
        
        let size = Pos.calculate(model: toolManager, item: item, size: size)
        item.x = size.x
        item.y = size.y
        
        guard let data = image.heicData() else { return }
        let media = PPMediaModel(media: data)
        
        item.media = media
        
        let page = toolManager.activePage
        item.index = page?.items?.count ?? 0
        page?.items?.append(item)
        
        page?.store(item, type: .create) {
            item
        }
        
        toolManager.activeItem = item
    }
    
    func primaryColor() -> Color {
        let page = toolManager.activePage
        
        if page?.color == "pageblack" || page?.color == "pagegray" {
            return Color.white
        } else {
            return Color.black
        }
    }
}
