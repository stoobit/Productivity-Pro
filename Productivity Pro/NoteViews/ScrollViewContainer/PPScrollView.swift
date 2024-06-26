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
    
    var scrollView: UIScrollView
    
    var isPortrait: Bool
    var proxy: GeometryProxy
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    
    var content: () -> Content
    
    func makeUIView(context: Context) -> UIScrollView {
        scrollView.delegate = context.coordinator
        
        scrollView.bouncesZoom = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.minimumZoomScale = minimumScale
        
        #if DEBUG
        scrollView.maximumZoomScale = 5
        #else
        scrollView.maximumZoomScale = 2.3
        #endif
        
        let hostedView = context.coordinator.hostingController.view!
        hostedView.backgroundColor = .secondarySystemBackground
        hostedView.frame = CGRect(
            x: 0, y: 0,
            width: getFrame().width,
            height: getFrame().height
        )
        
        scrollView.addSubview(hostedView)
        scrollView.setZoomScale(fitScale(), animated: false)
        
        let singleTap = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.singleTap)
        )
        
        singleTap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.doubleTap)
        )
        
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        scrollView.subviews.last?.addGestureRecognizer(doubleTap)
        
        Task { @MainActor in
            try await Task.sleep(nanoseconds: 50000)
            toolManager.scale = scrollView.zoomScale
            toolManager.offset = scrollView.contentOffset
            
            scale = scrollView.zoomScale
            offset = scrollView.contentOffset
        }
        
        return scrollView
    }
    
    func fitScale() -> CGFloat {
        let frame = proxy.frame(in: .local)
        
        if isPortrait {
            return frame.width / shortSide
        } else {
            if frame.width > frame.height {
                return frame.width / longSide
            } else {
                return frame.height / shortSide
            }
        }
    }
    
    var minimumScale: CGFloat {
        let frame = proxy.frame(in: .local)
        
        if isPortrait {
            return frame.height / longSide
        } else {
            if frame.width > frame.height {
                return frame.height / shortSide
            } else {
                return frame.width / longSide
            }
        }
    }
    
    func getFrame() -> CGSize {
        return CGSize(
            width: isPortrait ? shortSide : longSide,
            height: isPortrait ? longSide : shortSide
        )
    }
}
