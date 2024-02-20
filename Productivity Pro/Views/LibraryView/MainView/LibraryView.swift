//
//  LibraryView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.horizontalSizeClass) var hsc
    @State var appClip: Bool = false
    
    var showBar: Bool = true
    let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScqlAMTAIt2DGzUsYyk8HkMphjBfU2arwxyTCm2a3moDwPEqw/viewform?usp=sf_link")!

    var body: some View {
        GeometryReader { proxy in
            Group {
                NavigationStack {
                    ZStack {
                        Color(UIColor.systemGroupedBackground)
                            .ignoresSafeArea(.all)

                        LibrarySubjectsList()
                    }
                    .navigationTitle("Bibliothek")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarRole(.editor)
                    .toolbar {
                        if showBar {
                            ToolbarItemGroup(placement: .topBarTrailing) {
                                Link(destination: url) {
                                    Label("Beitrag hinzufügen", systemImage: "person.fill.badge.plus")
                                }
                                
                                Button(action: { appClip.toggle() }) {
                                    Label("App Clip", systemImage: "appclip")
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $appClip) {
                        AppClipView()
                    }
                }
                .overlay {
                    if isAvailable(at: proxy.size) == false {
                        ZStack {
                            Color(UIColor.systemGroupedBackground)
                                .ignoresSafeArea(.all)

                            ContentUnavailableView(
                                "Diese Ansicht ist nicht verfügbar.",
                                systemImage: "eye.slash.fill",
                                description: Text("Bitte vergrößere dieses Fenster um auf die Bibliothek zuzugreifen.")
                            )
                        }
                    }
                }
            }
            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
        }
    }

    func isAvailable(at size: CGSize) -> Bool {
        var isAvailable = false
        let height = UIScreen.main.bounds.height / 1.5

        if hsc == .regular && size.height > height {
            isAvailable = true
        }

        return isAvailable
    }
}
