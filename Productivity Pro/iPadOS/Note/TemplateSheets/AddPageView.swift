//
//  PageSettingsView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.22.
//

import SwiftUI

struct AddPageView: View {
    
    @Binding var document: ProductivityProDocument
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
                        NoteBackgroundIcons(backgroundSelection: $backgroundTemplate, backgroundColor: $backgroundColor).LargeView()
                    }
                    
                    VStack {
                        BackgroundValueView()
                        NoteBackgroundIcons(backgroundSelection: $backgroundTemplate, backgroundColor: $backgroundColor).SmallView()
                    }
                }
            }
            .onAppear {
                let page = document.document.note.pages[toolManager.selectedPage]
                
                backgroundColor = page.backgroundColor
                isPortrait = page.isPortrait
                backgroundTemplate = page.backgroundTemplate
            }
            .navigationTitle("Select Template")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbarBackground(.visible, for: .navigationBar)
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
    
    func addPage() {
        
        let newPage = Page(
            backgroundColor: backgroundColor,
            backgroundTemplate: backgroundTemplate,
            isPortrait: isPortrait
        )
        
        toolManager.preloadedMedia.insert(
            nil, at: toolManager.selectedPage + 1
        )
        
        document.document.note.pages.insert(
            newPage, at: toolManager.selectedPage + 1
        )

        isPresented = false
        toolManager.selectedPage += 1
    }
}
