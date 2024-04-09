//
//  PPScrollViewUpdate.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.04.24.
//

import SwiftUI

extension PPScrollView {
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
            uiView.setZoomScale(getScale(), animated: false)
        }
        
        context.coordinator.hostingController.rootView = content()
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
}
