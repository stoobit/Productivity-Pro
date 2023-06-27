//
//  PageBackgroundScan.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.06.23.
//

import SwiftUI

struct PageBackgroundScan: View {
    @State var renderedBackground: UIImage?
    
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        
        Image(uiImage: renderedBackground ?? UIImage())
            .resizable()
            .scaledToFit()
            .frame(
                width: toolManager.zoomScale * getFrame().width,
                height: toolManager.zoomScale * getFrame().height
            )
            .scaleEffect(1/toolManager.zoomScale)
            .allowsHitTesting(false)
            .onAppear {
                if toolManager.selectedTab == page.id {
                    renderScan()
                } else {
                    renderPreview()
                }
            }
            .onDisappear {
                destroyScan()
            }
            .onChange(of: toolManager.selectedTab) { _ in
                if toolManager.selectedTab == page.id {
                    renderScan()
                }
            }
        
    }
    
    func renderPreview() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let media = page.backgroundMedia else { return }
            guard let uiImage = UIImage(data: media) else { return }
            
            renderedBackground = resize(
                uiImage, to: CGSize(
                    width: uiImage.size.width * 0.1,
                    height: uiImage.size.height * 0.1
                )
            )
        }
    }
    
    func renderScan() {
        if page.id == toolManager.selectedTab {
            DispatchQueue.global(qos: .userInitiated).async {
                guard let media = page.backgroundMedia else { return }
                let uiImage = UIImage(data: media)
                
                renderedBackground = uiImage
            }
        }
    }
    
    func destroyScan() {
        renderedBackground = nil
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
