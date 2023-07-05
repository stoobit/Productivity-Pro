//
//  PageBackgroundScan.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.06.23.
//

import SwiftUI

struct PageBackgroundScan: View, Equatable {
    @State private var renderedBackground: UIImage?
    
    @Binding var document: ProductivityProDocument
    @Binding var page: Page
    @Binding var offset: CGFloat
    
    @StateObject var toolManager: ToolManager
    
    var isOverview: Bool
    var body: some View {
        ZStack {
            
            if let rendering = renderedBackground {
                Image(uiImage: rendering)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: toolManager.zoomScale * getFrame().width,
                        height: toolManager.zoomScale * getFrame().height
                    )
                    .scaleEffect(1/toolManager.zoomScale)
                
            } else {
               LoadingView()
            }
        }
        .allowsHitTesting(false)
        .onAppear {
            if page.id == toolManager.selectedTab {
                render()
            } else {
                renderPreview()
            }
        }
        .onChange(of: offset) { value in
            if offset == 0 &&
                toolManager.selectedTab == page.id &&
                isOverview == false
            {
                render()
            }
        }
        .onDisappear {
            renderedBackground = nil
        }
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
    
    static func == (
        lhs: PageBackgroundScan,
        rhs: PageBackgroundScan
    ) -> Bool {
        true
    }
    
    func renderPreview() {
        if renderedBackground == nil {
            guard let media = page.backgroundMedia else { return }
            let image = UIImage(data: media) ?? UIImage()
            let resized = resize(image, to: CGSize(
                width: getFrame().width * 0.1,
                height: getFrame().height * 0.1)
            )
            
            renderedBackground = resized
        }
    }
    
    func render() {
        guard let media = page.backgroundMedia else { return }
        let image = UIImage(data: media) ?? UIImage()
        let resized = resize(image, to: getFrame())
        
        renderedBackground = resized
    }
    
    @ViewBuilder func LoadingView() -> some View {
        Text("Loading...")
            .font(.system(size: 20 * toolManager.zoomScale))
            .frame(
                width: toolManager.zoomScale * getFrame().width,
                height: toolManager.zoomScale * getFrame().height
            )
            .scaleEffect(1/toolManager.zoomScale)
    }
    
}
