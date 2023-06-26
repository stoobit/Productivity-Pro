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
            .task(priority: .userInitiated) {
                renderedBackground = UIImage(
                    data: page.backgroundMedia ?? Data()
                )
            }
            .onAppear {
                renderPreview()
            }
            .onDisappear {
                destroyScan()
            }
            .onChange(of: toolManager.selectedTab) { _ in
                renderScan()
            }
        
    }
    
    func renderPreview() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let media = page.backgroundMedia else { return }
            let uiImage = UIImage(data: media, scale: 0.3)
            
            renderedBackground = uiImage
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
        DispatchQueue.global(qos: .userInitiated).async {
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
}
