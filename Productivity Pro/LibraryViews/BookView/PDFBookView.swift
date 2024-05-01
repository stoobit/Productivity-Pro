//
//  PDFBookView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.04.24.
//

import PDFKit
import SwiftUI

struct PDFBookView: UIViewRepresentable {
    var book: PPBookModel
    var proxy: GeometryProxy

    @Binding var view: PDFView

    static func url(for book: PPBookModel) -> URL {
        return .documentsDirectory.appending(
            component: "\(book.filename).probook"
        )
    }

    func makeUIView(context: Context) -> PDFView {
        Task { @MainActor in
            view.delegate = context.coordinator

            // Load Data
            let pdf = PDFDocument(url: PDFBookView.url(for: book))
            view.document = pdf

            // Set Scale
            let page = pdf?.page(at: 0) ?? PDFPage()
            let rect = page.bounds(for: .mediaBox)

            view.autoScales = false
            view.scaleFactor = (proxy.size.width / rect.width) * 0.95
            view.minScaleFactor = view.scaleFactor
            view.maxScaleFactor = view.scaleFactor
            view.pageShadowsEnabled = false
            view.backgroundColor = .white
            view.hideScrollViewIndicator()
            view.go(to: pdf?.page(at: book.position) ?? PDFPage())

            // Return View
            return view
        }

        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        let page = uiView.document?.page(at: 0) ?? PDFPage()
        let rect = page.bounds(for: .mediaBox)

        uiView.scaleFactor = proxy.size.width / rect.width
        uiView.minScaleFactor = uiView.scaleFactor
        uiView.maxScaleFactor = uiView.scaleFactor
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension PDFView {
    func hideScrollViewIndicator() {
        for subview in subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.showsVerticalScrollIndicator = false
                scrollView.showsHorizontalScrollIndicator = false
                return
            }
        }
    }
}
