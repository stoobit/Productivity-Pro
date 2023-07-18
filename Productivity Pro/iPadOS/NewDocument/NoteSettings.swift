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
                        NoteBackgroundIcons(backgroundSelection: $backgroundTemplate, backgroundColor: $backgroundColor).LargeView()
                        
                        iOSEditingWarning()
                    }
                    
                    VStack {
                        BackgroundValueView()
                        NoteBackgroundIcons(backgroundSelection: $backgroundTemplate, backgroundColor: $backgroundColor).SmallView()
                        
                        iOSEditingWarning()
                        
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
            .toolbarBackground(.visible, for: .navigationBar)
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
    
    @ViewBuilder func iOSEditingWarning() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            Spacer()
            Text("Document editing is currently not available on iOS.\nPlease install Productivity Pro on Your iPad or Mac to edit documents.")
                .foregroundColor(.secondary)
                .font(.caption)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
    
    @ViewBuilder func BackgroundValueView() -> some View {
        VStack {
            Button(action: { withAnimation { isPortrait.toggle() } }) {
                Text("Layout")
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                RectangleRotationIcon()
                    .rotationEffect(Angle(degrees: isPortrait ? 0 : 90))
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
            
#if DEBUG
            let canvasType: CanvasType = .ppDrawingKit
#else
            let canvasType: CanvasType = .pencilKit
#endif
            
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
