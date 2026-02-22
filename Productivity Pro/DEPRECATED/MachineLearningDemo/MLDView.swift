//
//  MLDView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.01.26.
//

import SwiftUI

struct MLDView: View {
    @State var model = MLViewModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.background.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            CanvasView(model: model)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay {
                   SquaredViewPortrait()
                }
                .clipped()
                .ignoresSafeArea(.container, edges: .bottom)
        }
        .navigationTitle(contentObject.title)
        .navigationSubtitle(Text("Seite 1 von 1"))
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Bookmark", systemImage: "bookmark") { }
                    .tint(Color.red)
                
                Button("Overview", systemImage: "square.grid.2x2") { }
            }
            
            ToolbarSpacer(placement: .topBarLeading)
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Share", systemImage: "square.and.arrow.up") { }
            }
            
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Reset", systemImage: "arrow.circlepath") {
                    model.reset()
                }
                
                Button("Add", systemImage: "plus") { }
                Button("Edit", systemImage: "paintbrush") { }
                    .disabled(true)
            }
            
            ToolbarSpacer(placement: .topBarTrailing)
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Undo", systemImage: "arrow.uturn.left") { }
                    .disabled(true)
                
                Button("Page Actions", systemImage: "doc.badge.ellipsis") { }
            }
        }
    }
    
    var contentObject: ContentObject {
        let id = UUID()
        let contentObject = ContentObject(
            id: id, title: "W-Seminar", type: .file,
            parent: id.uuidString, created: .init(), grade: 13
        )
        
        return contentObject
    }
    
    var page: PPPageModel {
        let page = PPPageModel(type: .template, index: 0)
        page.template = "squared"
        
        return page
    }
    
    @ViewBuilder func SquaredViewPortrait() -> some View {
        Path { path in
            
            for i in 1...35 {
                path.addRect(CGRect(
                    x: Double(i) * (shortSide / 36),
                    y: 0,
                    width: 1,
                    height: longSide)
                )
            }
            
            for i in 1...50 {
                path.addRect(CGRect(
                    x: 0,
                    y: Double(i) * (longSide / 51),
                    width: shortSide,
                    height: 1)
                )
            }
            
        }
        .fill(Color.secondary.opacity(0.4))
    }
}

#Preview {
    ContentView()
}
