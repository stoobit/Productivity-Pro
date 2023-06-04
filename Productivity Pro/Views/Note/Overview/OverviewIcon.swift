//
//  OverviewIcon.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI

struct OverviewIcon: View {
    
    @State var pageView: PageView?
    
    @Binding var document: Productivity_ProDocument
    let page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    let size: CGSize
    
    var body: some View {
        ZStack {
            pageView
                .scaleEffect(size.width / 4 / getFrame(page: page).width)
                .frame(
                    width: size.width / 4,
                    height: (size.width / 4 / getFrame(page: page).width) * getFrame(page: page).height
                )
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .allowsHitTesting(false)
                .disabled(true)
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(
                    page.id == toolManager.selectedTab ? Color.accentColor : Color.secondary,
                    lineWidth: 2
                )
                .frame(
                    width: size.width / 4,
                    height: (size.width / 4 / getFrame(page: page).width) * getFrame(page: page).height
                )
        }
        .onAppear {
            let tm = ToolManager()
            tm.zoomScale = 1
            
            pageView = PageView(
                document: $document,
                page: .constant(page),
                toolManager: tm,
                subviewManager: subviewManager,
                showBackground: true,
                showToolView: true,
                showShadow: false,
                isOverview: true,
                size:
                    CGSize(
                        width: size.width / 4,
                        height: (size.width / 4 / getFrame(page: page).width) * getFrame(page: page).height
                    )
            )
        }
    }
    
    func getFrame(page: Page) -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
}
