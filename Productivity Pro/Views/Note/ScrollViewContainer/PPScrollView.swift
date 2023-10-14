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
    
    var note: PPNoteModel
    var page: PPPageModel
    var size: CGSize
    
    @Binding var scale: CGFloat
    @Binding var offset: CGPoint
    
    var content: () -> Content
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        
        scrollView.bouncesZoom = false
        scrollView.isScrollEnabled = true
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let hostedView = context.coordinator.hostingController.view!
        hostedView.frame =  CGRect(
            x: 0,
            y: 0,
            width: getFrame().width,
            height: getFrame().height
        )
        
        hostedView.backgroundColor = .secondarySystemBackground
        scrollView.addSubview(hostedView)
        
        scrollView.setZoomScale(getScale(), animated: false)
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if uiView.minimumZoomScale != getScale() {
            uiView.minimumZoomScale = getScale()
            
            if getScale() > uiView.zoomScale {
                uiView.setZoomScale(getScale(), animated: true)
            }
        }
        
        if uiView.maximumZoomScale != 2.2 {
            uiView.maximumZoomScale = 2.2
            uiView.setZoomScale(getScale(), animated: true)
        }
        
        if toolManager.isLocked {
            uiView.isScrollEnabled = false
            uiView.pinchGestureRecognizer?.isEnabled = false
        } else {
            uiView.isScrollEnabled = true
            uiView.pinchGestureRecognizer?.isEnabled = true
        }
        
        context.coordinator.hostingController.rootView = content()
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        @Bindable var toolValue = toolManager
        
        return Coordinator(
            hostingController: UIHostingController(
                rootView: self.content()
            ),
            scale: $scale,
            offset: $offset,
            editorVisible: $toolValue.editorVisible,
            frameVisible: $toolValue.frameVisible
        )
    }
    
    @MainActor
    class Coordinator: NSObject, UIScrollViewDelegate {
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
            frameVisible: Binding<Bool>
        ) {
            self.hostingController = hostingController
            _scale = scale
            _offset = offset
            _editorVisible = editorVisible
            _frameVisible = frameVisible
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            editorVisible = false
            frameVisible = false
        }
        
        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            
            self.scale = scrollView.zoomScale
            self.offset = scrollView.contentOffset
            
            editorVisible = true
            frameVisible = true
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if decelerate == false {
                offset = scrollView.contentOffset
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            offset = scrollView.contentOffset
        }

        func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
            offset = scrollView.contentOffset
        }
    }
    
    func getScale() -> CGFloat {
        var scale: CGFloat = 0
        
        if page.isPortrait {
            scale = size.width / shortSide
        } else {
            scale = size.width / longSide
        }
        
        return scale
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
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
