//
//  PageSettingsView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.22.
//

import SwiftUI

struct AddPageView: View {
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    @Binding var document: Document
    @Binding var isPresented: Bool
    
    @State var backgroundColor: String = "pagewhite"
    @State var isPortrait: Bool = true
    @State var backgroundTemplate: String = "blank"
    
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ViewThatFits {
                    VStack {
                        BackgroundValueView()
//                        NoteBackgroundIcons(backgroundSelection: $backgroundTemplate, backgroundColor: $backgroundColor).LargeView()
                    }
                    
                    VStack {
                        BackgroundValueView()
//                        NoteBackgroundIcons(backgroundSelection: $backgroundTemplate, backgroundColor: $backgroundColor).SmallView()
                    }
                }
                .animation(
                    isPresented == false ? .linear(duration: 0) : .linear(duration: 0.2),
                    value: backgroundColor
                )
            }
            .onAppear {
                let page = document.note.pages[toolManager.selectedPage]
                
                backgroundColor = page.backgroundColor
                isPortrait = page.isPortrait
                backgroundTemplate = page.backgroundTemplate
            }
            .navigationTitle("Select Template")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { addPage() }) {
                        Image(systemName: "doc.badge.plus")
                            .fontWeight(.regular)
                    }
                    .keyboardShortcut(.return, modifiers: [])
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented.toggle() }
                        .keyboardShortcut(.escape, modifiers: [])
                }
            }
        }
    }
    
    @ViewBuilder func BackgroundValueView() -> some View {
        VStack {
            Button(action: { withAnimation { isPortrait.toggle() } }) {
                Text("Layout")
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
            }
            .padding(.vertical, 5)
            
            Divider()
                .padding(.vertical, 5)
            
            HStack {
                Text("Color")
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
                ColorCircle("pagewhite")
                ColorCircle("pageyellow")
                ColorCircle("pagegray")
                ColorCircle("pageblack")
                
            }
            .padding(.top)
            .padding(.vertical, 5)
        }
        .padding()
    }
    
    @ViewBuilder func ColorCircle(_ value: String) -> some View {
        Button(action: { backgroundColor = value }) {
            Circle()
                .fill(Color(value))
                .frame(width: 30, height: 30)
                .padding(.horizontal, 10)
                .overlay {
                    Circle()
                        .stroke(
                            backgroundColor == value ?
                            Color.accentColor : Color.secondary,
                            lineWidth: 3
                        )
                }
        }
    }
    
    func addPage() {
        
        savedBackgroundColor = backgroundColor
        savedBackgroundTemplate = backgroundTemplate
        savedIsPortrait = isPortrait
        
        let canvasType: CanvasType = .pencilKit
        
        let newPage = Page(
            canvasType: canvasType,
            backgroundColor: backgroundColor,
            backgroundTemplate: backgroundTemplate,
            isPortrait: isPortrait
        )
        
        toolManager.preloadedMedia.insert(
            nil, at: toolManager.selectedPage + 1
        )
        
        document.note.pages.insert(
            newPage, at: toolManager.selectedPage + 1
        )

        isPresented = false
        toolManager.selectedPage += 1
    }
}
