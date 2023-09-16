//
//  NoteSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.09.22.
//

import SwiftUI

struct NoteSettings: View {
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @Binding var document: Document
    let dismiss: () -> Void
    
    @State var backgroundColor: String = "pagewhite"
    @State var isPortrait: Bool = true
    @State var backgroundTemplate: String = "blank"
    
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
                    subviewManager.newDocTemplate == false ? .linear(duration: 0) : .linear(duration: 0.2),
                    value: backgroundColor
                )
            }
            .navigationTitle("Select Template")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) { Button("Create") { create() }
                        .keyboardShortcut(.return, modifiers: [])
                }
                
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") {
                        subviewManager.newDocTemplate = false
                    }
                    .keyboardShortcut(.return, modifiers: [])
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
    
    func create() {
        withAnimation {
            
            document.documentType = .note
            
let canvasType: CanvasType = .pencilKit
            
            var note = Note()
            let firstPage: Page = Page(
                canvasType: canvasType,
                backgroundColor: backgroundColor,
                backgroundTemplate: backgroundTemplate,
                isPortrait: isPortrait
            )
            
            toolManager.preloadedMedia.append(nil)
            note.pages.append(firstPage)
            document.note = note
            
            savedBackgroundColor = backgroundColor
            savedBackgroundTemplate = backgroundTemplate
            savedIsPortrait = isPortrait
            
            dismiss()
        }
    }
}
