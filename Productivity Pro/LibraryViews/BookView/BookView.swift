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
                }
                .toolbar(id: "tools") {
                    ToolbarItem(id: "Blau", placement: .secondaryAction) {
                        Button("Blau", systemImage: "circle.fill") {
                            highlight(.blue)
                        }
                        .tint(Color.blue)
                    }

                    ToolbarItem(id: "Gelb", placement: .secondaryAction) {
                        Button("Gelb", systemImage: "circle.fill") {
                            highlight(.yellow)
                        }
                        .tint(Color.yellow)
                    }

                    ToolbarItem(id: "Grün", placement: .secondaryAction) {
                        Button("Grün", systemImage: "circle.fill") {
                            highlight(.green)
                        }
                        .tint(Color.green)
                    }

                    ToolbarItem(id: "Rot", placement: .secondaryAction) {
                        Button("Rot", systemImage: "circle.fill") {
                            highlight(.red)
                        }
                        .tint(Color.red)
                    }

                    Group {
                        ToolbarItem(id: "Orange", placement: .secondaryAction) {
                            Button("Orange", systemImage: "circle.fill") {
                                highlight(.orange)
                            }
                            .tint(Color.orange)
                        }

                        ToolbarItem(id: "Lila", placement: .secondaryAction) {
                            Button("Lila", systemImage: "circle.fill") {
                                highlight(.purple)
                            }
                            .tint(Color.purple)
                        }

                        ToolbarItem(id: "Mint", placement: .secondaryAction) {
                            Button("Mint", systemImage: "circle.fill") {
                                highlight(.mint)
                            }
                            .tint(Color.mint)
                        }

                        ToolbarItem(id: "Pink", placement: .secondaryAction) {
                            Button("Pink", systemImage: "circle.fill") {
                                highlight(.pink)
                            }
                            .tint(Color.pink)
                        }

                        ToolbarItem(id: "Braun", placement: .secondaryAction) {
                            Button("Braun", systemImage: "circle.fill") {
                                highlight(.brown)
                            }
                            .tint(Color.brown)
                        }
                    }
                    .defaultCustomization(.hidden)

                    ToolbarItem(id: "Remove", placement: .secondaryAction) {
                        Button("Entfernen", systemImage: "circle.slash") {
                            remove()
                        }
                        .tint(Color.primary)
                    }
                }
                .modifier(OrientationUpdater(isPortrait: toggle))
                .onChange(of: proxy.size) {
                    toggle.toggle()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.smooth(duration: 0.2)) {
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

    func highlight(_ color: Color) {
        guard let selection = view.currentSelection else { return }
        let selections = selection.selectionsByLine()

        selections.forEach { selection in
            selection.pages.forEach { page in
                let highlight = PDFAnnotation(
                    bounds: selection.bounds(for: page),
                    forType: .highlight,
                    withProperties: nil
                )

                highlight.color = UIColor(color)
                page.addAnnotation(highlight)
            }
        }
    }

    func remove() {
        guard let selection = view.currentSelection else { return }
        let selections = selection.selectionsByLine()

        selections.forEach { selection in
            selection.pages.forEach { page in
                for annotation in page.annotations {
                    if selection.bounds(for: page).contains(annotation.bounds) {
                        page.removeAnnotation(annotation)
                    } else if annotation.bounds.contains(selection.bounds(for: page)) {
                        page.removeAnnotation(annotation)
                    }
                }
            }
        }
    }

    func save(task: Bool = true) {
        book.position = view.document?.index(
            for: view.currentPage ?? PDFPage()
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
