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
    
    @MainActor func add(image: Image) {
        let selectedImage = image.asUIImage()
        
        let image = resize(selectedImage, to: CGSize(width: 2048, height: 2048))
        let ratio = 400/image.size.width
        
        let item = PPItemModel(index: 0, type: .media)
        item.width = image.size.width * ratio
        item.height = image.size.height * ratio
        
        let size = toolManager.offset.size
        let scale = (1/toolManager.scale)
        
        item.x = size.width * scale + item.width/2 + 40
        item.y = size.height * scale + item.height/2 + 40
        
        guard let data = image.heicData() else { return }
        let media = PPMediaModel(media: data)
        
        item.media = media
        
        let page = toolManager.activePage
        item.index = page?.items?.count ?? 0
        page?.items?.append(item)
        
        toolManager.activeItem = item
    }
}
