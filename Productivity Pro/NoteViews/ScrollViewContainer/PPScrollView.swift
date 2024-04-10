//
//  PPScrollView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.10.22.
//

import SwiftUI

@MainActor
struct PPScrollView<Content: View>: UIViewRepresentable {
    @Environment(ToolManager.self) var toolManager
    @Environment(SubviewManager.self) var subviewManager
    
    var isPortrait: Bool
    var size: CGSize
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    
    var content: () -> Content
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        
        scrollView.bouncesZoom = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.minimumZoomScale = minimumScale()
        scrollView.maximumZoomScale = 2.2
        
        let hostedView = context.coordinator.hostingController.view!
        hostedView.backgroundColor = .secondarySystemBackground
        hostedView.frame = CGRect(
            x: 0, y: 0,
            width: getFrame().width,
            height: getFrame().height
        )
        
        scrollView.addSubview(hostedView)
        scrollView.setZoomScale(fitScale(), animated: false)
        
        Task { @MainActor in
            scale = scrollView.zoomScale
        }
        
        return scrollView
    }
    
    func fitScale() -> CGFloat {
        return size.width / (isPortrait ? shortSide : longSide)
    }
    
    func minimumScale() -> CGFloat {
        return (size.height / (isPortrait ? longSide : shortSide)) * 0.8
    }
    
    func getFrame() -> CGSize {
        return CGSize(
            width: isPortrait ? shortSide : longSide,
            height: isPortrait ? longSide : shortSide
        )
    }
}
