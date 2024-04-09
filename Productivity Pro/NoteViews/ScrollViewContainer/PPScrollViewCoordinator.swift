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
}
