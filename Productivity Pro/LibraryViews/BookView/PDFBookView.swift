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

    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        Task { @MainActor in

            // Load Data
            guard let url = Bundle.main.url(
                forResource: book.filename, withExtension: "pdf"
            ) else {
                return view
            }

            let pdf = PDFDocument(url: url)
            view.document = pdf

            // Set Scale
            let page = pdf?.page(at: 0) ?? PDFPage()
            let rect = page.bounds(for: .mediaBox)

            view.autoScales = false
            view.scaleFactor = proxy.size.width / rect.width
            view.minScaleFactor = view.scaleFactor
            view.maxScaleFactor = view.scaleFactor
            view.pageShadowsEnabled = false
            view.backgroundColor = .white
            view.hideScrollViewIndicator()

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
}

extension PDFView {
    func hideScrollViewIndicator() {
        for subview in subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.showsVerticalScrollIndicator = false
                scrollView.showsHorizontalScrollIndicator = false
                scrollView.setContentOffset(.zero, animated: false)
                return
            }
        }
    }
}
