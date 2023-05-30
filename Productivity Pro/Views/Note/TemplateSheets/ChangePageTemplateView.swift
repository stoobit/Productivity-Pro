//
//  ChangePageTemplateView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.10.22.
//

import SwiftUI

struct ChangePageTemplateView: View {
    
    @Binding var document: Productivity_ProDocument
    @Binding var isPresented: Bool
    
    @StateObject var toolManager: ToolManager
    
    @State var backgroundColor: String = "white"
    @State var isPortrait: Bool = true
    @State var backgroundTemplate: String = "blank"
    
    let save: () -> Void
    
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
            .navigationTitle("Change Page Template")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { changeTemplate() }) {
                        Image(systemName: "doc.badge.gearshape")
                            .fontWeight(.regular)
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented.toggle() }
                }
            }
            .onAppear {
                backgroundColor = document.document.note.pages[
                    toolManager.selectedPage
                ].backgroundColor
                
                backgroundTemplate = document.document.note.pages[
                    toolManager.selectedPage
                ].backgroundTemplate
                
                isPortrait = document.document.note.pages[
                    toolManager.selectedPage
                ].isPortrait
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
                
                ColorCircle("white")
                ColorCircle("yellow")
                ColorCircle("gray")
                ColorCircle("black")
                
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
    
    func changeTemplate() {
        save()
        var index = 0
        
        if document.document.note.pages.count == 1 {
            index = document.document.note.pages.firstIndex(of: document.document.note.pages.first!)!
        } else {
            index = toolManager.selectedPage
        }
        
        document.document.note.pages[index].backgroundColor = backgroundColor
        document.document.note.pages[index].backgroundTemplate = backgroundTemplate
        document.document.note.pages[index].isPortrait = isPortrait
        
        isPresented = false
    }
    
}
