//
//  PageBackgroundView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.06.23.
//

import SwiftUI

struct PageBackgroundView: View {
    @Environment(ToolManager.self) var toolManager
    @Binding var scale: CGFloat
    
    var page: PPPageModel
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(page.color))
            .frame(
                width: scale * getFrame().width,
                height: scale * getFrame().height
            )
            .scaleEffect(1 / scale)
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
