//
//  PKCoordinator.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import PencilKit
import SwiftUI

final class Coordinator: NSObject, PKCanvasViewDelegate {
    @Bindable var page: PPPageModel

    init(page: PPPageModel) {
        self.page = page
    }

    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        Task { @MainActor in
            page.canvas = canvasView.drawing.dataRepresentation()
        }
    }
}
