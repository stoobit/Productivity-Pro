//
//  SnapItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.03.23.
//

import SwiftUI

struct SnapItemView: View {
    
    @Bindable var toolManager: ToolManager
    @Binding var page: Page
    
    var body: some View {
        ZStack {
            
            if toolManager.showSnapper[0] == true {
                HStack {
                    Spacer()
                    SnapLine(
                        width: 1, height: getFrame().height * toolManager.zoomScale
                    )
                    Spacer()
                }
            }
            
            if toolManager.showSnapper[1] == true {
                VStack {
                    Spacer()
                    SnapLine(
                        width: getFrame().width * toolManager.zoomScale, height: 1
                    )
                    Spacer()
                }
            }
        }
        .frame(
            width: getFrame().width * toolManager.zoomScale,
            height: getFrame().height * toolManager.zoomScale
        )
        
    }
    
    @ViewBuilder func SnapLine(width: CGFloat, height: CGFloat) -> some View {
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor(.accentColor)
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
