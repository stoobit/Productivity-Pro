//
//  PageBackgroundView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.06.23.
//

import SwiftUI

struct PageBackgroundView: View {
    
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(page.backgroundColor))
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
