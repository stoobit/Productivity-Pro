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
                    if scenePhase != .active {
                        save(task: false)
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button(action: {
                            save()
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.bouncy) {
                            showCover = false
                        }
                    }
                }
        }
        .overlay {
            if showCover {
                Cover()
                    .transition(.opacity)
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
            }
        }
    }

    func save(task: Bool = true) {
        book.position = view.document?.index(
            for: view.currentPage!
        ) ?? book.position

        if task {
            Task(priority: .userInitiated) {
                await view.document?.write(to: PDFBookView.url(for: book))
            }
        } else {
            view.document?.write(to: PDFBookView.url(for: book))
        }
    }

    @ViewBuilder func Cover() -> some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)

            Image(book.image)
                .interpolation(.high)
                .resizable()
                .frame(width: 240, height: 240)
                .clipShape(.rect(cornerRadius: 16))
        }
    }
}
