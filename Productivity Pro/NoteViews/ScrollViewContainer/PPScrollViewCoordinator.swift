//
//  PPScrollViewCoordinator.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.04.24.
//

import SwiftUI

extension PPScrollView {
    @MainActor
    final class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: PPScrollView
        
        @Bindable var toolManager: ToolManager
        var hostingController: UIHostingController<Content>
        
        @Binding var scale: CGFloat
        @Binding var offset: CGPoint
        
        init(
            parent: PPScrollView,
            hostingController: UIHostingController<Content>,
            scale: Binding<CGFloat>, offset: Binding<CGPoint>,
            toolManager: ToolManager
        ) {
            self.parent = parent
            self.hostingController = hostingController
            self.toolManager = toolManager
            
            _scale = scale
            _offset = offset
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            let bounds = scrollView.bounds
            let size = scrollView.contentSize
            
            let offsetX = max((bounds.width - size.width) * 0.5, 0)
            let offsetY = max((bounds.height - size.height) * 0.5, 0)
            
            scrollView.contentInset = UIEdgeInsets(
                top: offsetY, left: offsetX, bottom: 0, right: 0
            )
        }
        
        func scrollViewWillBeginZooming(
            _ scrollView: UIScrollView, with view: UIView?
        ) {
            Task { @MainActor in
                toolManager.editorVisible = false
                toolManager.frameVisible = false
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
                
                toolManager.editorVisible = true
                toolManager.frameVisible = true
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
        
        @objc func doubleTap() {
            Task { @MainActor in
                let scale = parent.fitScale()
                parent.scrollView.setZoomScale(scale, animated: true)
                
                self.scale = scale
                toolManager.scale = scale
                
                self.offset = parent.scrollView.contentOffset
                toolManager.offset = parent.scrollView.contentOffset
            }
        }
        
        @objc func singleTap() {
            Task { @MainActor in
                toolManager.activeItem = nil
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        @Bindable var toolValue = toolManager
        
        return Coordinator(
            parent: self,
            hostingController: UIHostingController(rootView: content()),
            scale: $scale, offset: $offset, toolManager: toolValue
        )
    }
}
