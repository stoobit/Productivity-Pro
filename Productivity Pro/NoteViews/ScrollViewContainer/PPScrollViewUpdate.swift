//
//  PPScrollViewUpdate.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.04.24.
//

import SwiftUI

extension PPScrollView {
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        let minimumScale = minimumScale()

        if minimumScale != uiView.minimumZoomScale {
            uiView.minimumZoomScale = minimumScale
            if uiView.zoomScale < minimumScale {
                uiView.setZoomScale(minimumScale, animated: true)
            }

            Task { @MainActor in
                scale = minimumScale
            }
        }

        context.coordinator.hostingController.rootView = content()
        assert(
            context.coordinator.hostingController.view.superview == uiView
        )
    }
}
