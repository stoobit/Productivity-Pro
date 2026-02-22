//
//  PDFBookViewClass.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.05.24.
//

import PDFKit
import SwiftUI

extension PDFBookView {
    class Coordinator: NSObject, PDFViewDelegate {
        var parent: PDFBookView
        init(_ parent: PDFBookView) {
            self.parent = parent
        }
    }
}
