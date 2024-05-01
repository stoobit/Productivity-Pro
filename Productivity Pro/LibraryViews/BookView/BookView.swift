//
//  BookView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.04.24.
//

import PDFKit
import SwiftUI

struct BookView: View {
    @Environment(\.dismiss) var dismiss
    var book: PPBookModel

    @State var view = PDFView()

    var body: some View {
        GeometryReader { proxy in
            PDFBookView(book: book, proxy: proxy, view: $view)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationTitle(book.title)
                .toolbarRole(.browser)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button(action: { dismiss() }) {
                            Label("Zurück", systemImage: "chevron.left")
                        }
                    }

                    ToolbarItemGroup(placement: .secondaryAction) {
                        Button("Highlight", systemImage: "highlighter") {
                            highlight()
                        }
                    }
                    
//                    ToolbarItemGroup(placement: .secondaryAction) {
//                        Button("Highlight", systemImage: "highlighter") {
//                            highlight()
//                        }
//                    }
                }
        }
    }

    func highlight() {
        guard let selections = view.currentSelection?.selectionsByLine()
        else { return }
        
        selections.forEach { selection in
            selection.pages.forEach { page in
                let highlight = PDFAnnotation(
                    bounds: selection.bounds(for: page),
                    forType: .highlight,
                    withProperties: nil
                )
                
                highlight.color = .yellow
                
                let point = CGPoint(
                    x: selection.bounds(for: page).minX, y: selection.bounds(for: page).minY
                )
                
                if (page.annotation(at: point) == nil) {
                    page.addAnnotation(highlight)
                } else {
                    page.removeAnnotation(highlight)
                }
            }
        }
        
        view.document?.write(to: PDFBookView.url(for: book))
    }
}
