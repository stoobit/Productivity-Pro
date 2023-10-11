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
    
    var contentObject: ContentObject
    var size: CGSize
    
    var scrollView: UIScrollView
    var content: () -> Content
    
    func makeUIView(context: Context) -> UIScrollView {
        
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
            uiView.setZoomScale(getScale(), animated: true)
        }
        
        if toolManager.isLocked {
            uiView.isScrollEnabled = false
            uiView.pinchGestureRecognizer?.isEnabled = false
        } else {
            uiView.isScrollEnabled = true
            uiView.pinchGestureRecognizer?.isEnabled = true
        }
        
//        if toolManager.selectedTab != page.id ||
//            subviewManager.showScanDoc ||
//            subviewManager.showImportFile
//        {
//            uiView.setZoomScale(getScale(), animated: true)
//            uiView.setContentOffset(.zero, animated: true)
//        }
        
        context.coordinator.hostingController.rootView = content()
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(
            hostingController: UIHostingController(
                rootView: self.content()
            )
        )
    }
    
    @MainActor
    class Coordinator: NSObject, UIScrollViewDelegate {
        @Environment(ToolManager.self) var toolManager
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
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
            toolManager.isEditorVisible = false
            toolManager.showFrame = false
        }
        
        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            toolManager.didZoom = !(scrollView.zoomScale == scrollView.minimumZoomScale)
            
            toolManager.zoomScale = scrollView.zoomScale
            toolManager.scrollOffset = scrollView.contentOffset
            toolManager.isEditorVisible = true
            toolManager.showFrame = true
        }
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            toolManager.isLockEnabled = false
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if decelerate == false {
                toolManager.scrollOffset = scrollView.contentOffset
                toolManager.isLockEnabled = true
            }
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            toolManager.scrollOffset = scrollView.contentOffset
            toolManager.isLockEnabled = true
        }

        func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
            toolManager.scrollOffset = scrollView.contentOffset
        }
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
//        if page.isPortrait {
//            frame = CGSize(
//                width: shortSide,
//                height: longSide
//            )
//        } else {
//            frame = CGSize(width: longSide, height: shortSide)
//        }
        
        return frame
    }
    
    func getScale() -> CGFloat {
        var scale: CGFloat = 0
        
//        if page.isPortrait {
//            scale = size.width / shortSide
//        } else {
//            scale = size.width / longSide
//        }
        
        return scale
    }
}
