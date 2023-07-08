//
//  ZoomableScrollView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.10.22.
//

import SwiftUI

@MainActor
struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    
    var size: CGSize
    
    @Binding var document: ProductivityProDocument
    @Binding var page: Page
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
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
        hostedView.frame =  CGRect(
            x: 0,
            y: 0,
            width: getFrame().width,
            height: getFrame().height
        )
        
        hostedView.backgroundColor = .secondarySystemBackground
        scrollView.addSubview(hostedView)
        
        toolManager.zoomScale = getScale()
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if uiView.minimumZoomScale != getScale() {
            uiView.minimumZoomScale = getScale()
            
            if getScale() > uiView.zoomScale {
                uiView.setZoomScale(getScale(), animated: true)
            }
        }
        
        // Triggers View Update
        // Seems unnecessary, but DO NOT remove
        if uiView.maximumZoomScale != 2.2 {
            uiView.maximumZoomScale = 2.2
            uiView.setZoomScale(getScale(), animated: false)
        }
        
        if toolManager.isLocked {
            uiView.isScrollEnabled = false
            uiView.pinchGestureRecognizer?.isEnabled = false
        } else {
            uiView.isScrollEnabled = true
            uiView.pinchGestureRecognizer?.isEnabled = true
        }
        
        if toolManager.selectedTab != page.id ||
            subviewManager.showScanDoc ||
            subviewManager.showImportFile
        {
            uiView.setZoomScale(getScale(), animated: true)
            uiView.setContentOffset(.zero, animated: true)
        }
        
        context.coordinator.hostingController.rootView = content()
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            hostingController: UIHostingController(rootView: self.content()),
            didZoom: $toolManager.didZoom,
            scale: $toolManager.zoomScale,
            offset: $toolManager.scrollOffset,
            isEditorVisible: $toolManager.isEditorVisible,
            showFrame: $toolManager.showFrame,
            isLockEnabled: $toolManager.isLockEnabled
        )
    }
    
    @MainActor
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var hostingController: UIHostingController<Content>
        @Binding var didZoom: Bool
        @Binding var scale: CGFloat
        @Binding var offset: CGPoint
        
        @Binding var isEditorVisible: Bool
        @Binding var showFrame: Bool
        
        @Binding var isLockEnabled: Bool
        
        init(
            hostingController: UIHostingController<Content>,
            didZoom: Binding<Bool>,
            scale: Binding<CGFloat>,
            offset: Binding<CGPoint>,
            isEditorVisible: Binding<Bool>,
            showFrame: Binding<Bool>,
            isLockEnabled: Binding<Bool>
        ) {
            self.hostingController = hostingController
            _didZoom = didZoom
            _scale = scale
            _offset = offset
            _isEditorVisible = isEditorVisible
            _showFrame = showFrame
            _isLockEnabled = isLockEnabled
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
//            let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
//            let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
//            scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            isEditorVisible = false
            showFrame = false
        }
        
        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            didZoom = !(scrollView.zoomScale == scrollView.minimumZoomScale)
            
            self.scale = scrollView.zoomScale
            self.offset = scrollView.contentOffset
            isEditorVisible = true
            showFrame = true
        }
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            self.isLockEnabled = false
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if decelerate == false {
                self.offset = scrollView.contentOffset
                self.isLockEnabled = true
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            self.offset = scrollView.contentOffset
            self.isLockEnabled = true
        }

        func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
            self.offset = scrollView.contentOffset
        }
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
    
    func getScale() -> CGFloat {
        var scale: CGFloat = 0
        
        if page.isPortrait {
            scale = size.width / shortSide
        } else {
            scale = size.width / longSide
        }
        
        return scale
    }
}
