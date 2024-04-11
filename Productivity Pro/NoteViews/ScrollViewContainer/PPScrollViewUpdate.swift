//
//  PPScrollViewUpdate.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.04.24.
//

import SwiftUI

extension PPScrollView {
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if minimumScale != uiView.minimumZoomScale {
            uiView.minimumZoomScale = minimumScale
            uiView.setZoomScale(fitScale(), animated: true)
            uiView.setContentOffset(.zero, animated: true)

            Task { @MainActor in
                toolManager.scale = fitScale()
                scale = fitScale()
                
                toolManager.offset = .zero
                offset = .zero
            }
        }

        context.coordinator.hostingController.rootView = content()
        assert(
            context.coordinator.hostingController.view.superview == uiView
        )
    }
}
