//
//  SnapItemView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 18.03.23.
//

import SwiftUI

struct SnapItemView: View {
    @Environment(ToolManager.self) var toolManager
    var page: PPPageModel
    
    @Binding var scale: CGFloat
   
    var body: some View {
        ZStack {
            
            if toolManager.showSnapper[0] == true {
                HStack {
                    Spacer()
                    SnapLine(
                        width: 1, height: getFrame().height * scale
                    )
                    Spacer()
                }
            }
            
            if toolManager.showSnapper[1] == true {
                VStack {
                    Spacer()
                    SnapLine(
                        width: getFrame().width * scale, height: 1
                    )
                    Spacer()
                }
            }
        }
        .zIndex(1000)
        .frame(
            width: getFrame().width * scale,
            height: getFrame().height * scale
        )
        
    }
    
    @ViewBuilder func SnapLine(width: CGFloat, height: CGFloat) -> some View {
        Rectangle()
            .frame(width: width, height: height)
            .foregroundStyle(Color.accentColor)
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
