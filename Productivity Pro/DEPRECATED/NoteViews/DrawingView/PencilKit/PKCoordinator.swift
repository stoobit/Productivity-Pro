//
//  PKCoordinator.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import PencilKit
import SwiftUI

final class Coordinator: NSObject, PKCanvasViewDelegate {
    var parent: PKRepresentable
    @Bindable var page: PPPageModel

    init(_ parent: PKRepresentable, page: PPPageModel) {
        self.parent = parent
        self.page = page
    }

    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {}
}
