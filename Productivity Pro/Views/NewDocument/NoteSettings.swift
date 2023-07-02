//
//  NoteSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.09.22.
//

import SwiftUI

struct NoteSettings: View {
    
    @StateObject var subviewManager: SubviewManager
    @Binding var document: Document
    let dismiss: () -> Void
    
    @State var backgroundColor: String = "pagewhite"
    @State var isPortrait: Bool = true
    @State var backgroundTemplate: String = "blank"
    
    var body: some View {
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
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) { Button("Create") { create() }
                    .keyboardShortcut(.return, modifiers: [])
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
            Button(action: { isPortrait.toggle() }) {
                Text("Layout")
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                RectangleRotationIcon()
                    .rotationEffect(Angle(degrees: isPortrait ? 0 : 90))
                    .animation(.easeInOut, value: isPortrait)
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
        Button(action: { withAnimation { backgroundColor = value } }) {
            Circle()
                .fill(Color(value))
                .shadow(color: backgroundColor == value ? .clear : .primary, radius: 2)
                .frame(width: 30, height: 30)
                .padding(.horizontal, 10)
                .overlay {
                    if backgroundColor == value {
                        Circle()
                            .stroke(Color.accentColor, lineWidth: 3)
                    }
                }
        }
    }
    
    func create() {
        withAnimation {
            
            document.documentType = .note
            
            var note = Note()
            let firstPage: Page = Page(
                backgroundColor: backgroundColor,
                backgroundTemplate: backgroundTemplate,
                isPortrait: isPortrait
            )
            
            note.pages.append(firstPage)
            document.note = note
            
            dismiss()
        }
    }
}
