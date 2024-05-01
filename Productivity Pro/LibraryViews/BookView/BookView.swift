//
//  BookView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.04.24.
//

import PDFKit
import SwiftUI

struct BookView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    var book: PPBookModel

    @State var view = PDFView()
    @State var toggle: Bool = false
    @State var showCover: Bool = true

    var body: some View {
        GeometryReader { proxy in
            PDFBookView(book: book, proxy: proxy, view: $view)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationTitle(book.title)
                .toolbarRole(.browser)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .onChange(of: scenePhase) {
                    book.position = view.document?.index(
                        for: view.currentPage!
                    ) ?? book.position
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button(action: {
                            book.position = view.document?.index(
                                for: view.currentPage!
                            ) ?? book.position

                            dismiss()
                        }) {
                            Label("Zurück", systemImage: "chevron.left")
                        }
                    }

                    ToolbarItemGroup(placement: .secondaryAction) {
                        Button("Highlight", systemImage: "highlighter") {
                            highlight()
                        }
                    }
                }
                .modifier(OrientationUpdater(isPortrait: toggle))
                .onChange(of: proxy.size) {
                    toggle.toggle()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.bouncy) {
                            showCover = false
                        }
                    }
                }
        }
        .overlay {
            if showCover {
                
            }
        }
    }

    func highlight() {
        guard let selection = view.currentSelection else { return }
        let selections = selection.selectionsByLine()

        selections.forEach { selection in
            selection.pages.forEach { page in
                let highlight = PDFAnnotation(
                    bounds: selection.bounds(for: page),
                    forType: .highlight,
                    withProperties: nil
                )

                highlight.color = .yellow
                page.addAnnotation(highlight)

                book.annotations.append(highlight.encode())
            }
        }
    }
    
    @ViewBuilder func Cover() -> some View {
        Rectangle()
            .foregroundStyle(.background)
    }
}
