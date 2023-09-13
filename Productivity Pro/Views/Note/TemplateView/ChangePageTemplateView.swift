//
//  ChangePageTemplateView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.10.22.
//

import SwiftUI

struct ChangePageTemplateView: View {
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = ""
    
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = ""
    
    @Binding var document: Document
    @Binding var isPresented: Bool
    
    @StateObject var toolManager: ToolManager
    
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
                    isPresented == false ? .linear(duration: 0) : .linear(duration: 0.2),
                    value: backgroundColor
                )
            }
            .navigationTitle("Change Template")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { changeTemplate() }) {
                        Image(systemName: "doc.badge.gearshape")
                            .fontWeight(.regular)
                    }
                    .keyboardShortcut(.return, modifiers: [])
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented.toggle()
                    }
                    .keyboardShortcut(.escape, modifiers: [])
                }
            }
            .onAppear {
                backgroundColor = document.note.pages[
                    toolManager.selectedPage
                ].backgroundColor
                
                backgroundTemplate = document.note.pages[
                    toolManager.selectedPage
                ].backgroundTemplate
                
                isPortrait = document.note.pages[
                    toolManager.selectedPage
                ].isPortrait
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
    
    func changeTemplate() {
        var index = 0
        
        savedBackgroundColor = backgroundColor
        savedBackgroundTemplate = backgroundTemplate
        savedIsPortrait = isPortrait
        
        
        if document.note.pages.count == 1 {
            index = document.note.pages.firstIndex(of: document.note.pages.first!)!
        } else {
            index = toolManager.selectedPage
        }
        
        document.note.pages[index].backgroundColor = backgroundColor
        document.note.pages[index].backgroundTemplate = backgroundTemplate
        document.note.pages[index].isPortrait = isPortrait
        
        isPresented = false
    }
    
}
