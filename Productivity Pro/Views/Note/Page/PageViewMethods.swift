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
    func onDrop(items: [Data]) {
//        toolManager.showProgress = true
//
//        Task {
//            await MainActor.run {
//                for item in items {
//                    if let string = String(data: item, encoding: .utf8) {
//
//                    } else if let image = UIImage(data: item) {
//
//                    }
//                }
//
//                toolManager.showProgress = false
//            }
//        }
    }
    
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
}
