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
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        
        scrollView.bouncesZoom = false
        scrollView.isScrollEnabled = true
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let hostedView = context.coordinator.hostingController.view!
        hostedView.frame = CGRect(
            x: 0,
            y: 0,
            width: getFrame().width,
            height: getFrame().height
        )
        
        hostedView.backgroundColor = .secondarySystemBackground
        scrollView.addSubview(hostedView)
        
        scrollView.setZoomScale(getScale(), animated: false)
        
        Task { @MainActor in
            scale = scrollView.zoomScale
        }
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if uiView.minimumZoomScale != getScale() {
            uiView.minimumZoomScale = getScale()
            
            if getScale() > uiView.zoomScale {
                uiView.setZoomScale(getScale(), animated: true)
            }
            
            Task { @MainActor in
                scale = uiView.zoomScale
            }
        }
        
        if uiView.maximumZoomScale != 2.2 {
            uiView.maximumZoomScale = 2.2
            uiView.setZoomScale(getScale(), animated: true)
        }
        
        context.coordinator.hostingController.rootView = content()
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        @Bindable var toolValue = toolManager
        
        return Coordinator(
            hostingController: UIHostingController(
                rootView: content()
            ),
            scale: $scale,
            offset: $offset,
            editorVisible: $toolValue.editorVisible,
            frameVisible: $toolValue.frameVisible,
            toolManager: toolValue
        )
    }
    
    @MainActor
    final class Coordinator: NSObject, UIScrollViewDelegate {
        var toolManager: ToolManager
        var hostingController: UIHostingController<Content>
        
        @Binding var scale: CGFloat
        @Binding var offset: CGPoint
        
        @Binding var editorVisible: Bool
        @Binding var frameVisible: Bool
        
        init(
            hostingController: UIHostingController<Content>,
            scale: Binding<CGFloat>,
            offset: Binding<CGPoint>,
            editorVisible: Binding<Bool>,
            frameVisible: Binding<Bool>,
            toolManager: ToolManager
        ) {
            self.hostingController = hostingController
            _scale = scale
            _offset = offset
            _editorVisible = editorVisible
            _frameVisible = frameVisible
            self.toolManager = toolManager
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            Task { @MainActor in
                editorVisible = false
                frameVisible = false
            }
        }
        
        func scrollViewDidEndZooming(
            _ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat
        ) {
            Task { @MainActor in
                self.scale = scrollView.zoomScale
                self.offset = scrollView.contentOffset
                
                toolManager.scale = scrollView.zoomScale
                toolManager.offset = scrollView.contentOffset
                
                editorVisible = true
                frameVisible = true
            }
        }
        
        func scrollViewDidEndDragging(
            _ scrollView: UIScrollView, willDecelerate decelerate: Bool
        ) {
            Task { @MainActor in
                if decelerate == false {
                    offset = scrollView.contentOffset
                    
                    toolManager.scale = scrollView.zoomScale
                    toolManager.offset = scrollView.contentOffset
                }
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            Task { @MainActor in
                offset = scrollView.contentOffset
                
                toolManager.scale = scrollView.zoomScale
                toolManager.offset = scrollView.contentOffset
            }
        }

        func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
            Task { @MainActor in
                offset = scrollView.contentOffset
                
                toolManager.scale = scrollView.zoomScale
                toolManager.offset = scrollView.contentOffset
            }
        }
    }
    
    func getScale() -> CGFloat {
        var scale: CGFloat = 0
        
        if isPortrait {
            scale = size.width / shortSide
        } else {
            scale = size.width / longSide
        }
        
        return scale
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if isPortrait {
            frame = CGSize(
                width: shortSide,
                height: longSide
            )
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
}
