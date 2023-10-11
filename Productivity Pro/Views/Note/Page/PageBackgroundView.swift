//
//  PageBackgroundView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.06.23.
//

import SwiftUI

struct PageBackgroundView: View {
    @Environment(ToolManager.self) var toolManager
    var page: PPPageModel
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(page.color))
            .frame(
                width: toolManager.zoomScale * getFrame().width,
                height: toolManager.zoomScale * getFrame().height
            )
            .scaleEffect(1/toolManager.zoomScale)
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
    
}
