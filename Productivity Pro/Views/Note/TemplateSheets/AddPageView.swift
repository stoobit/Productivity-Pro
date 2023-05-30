//
//  PageSettingsView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 01.10.22.
//

import SwiftUI

struct AddPageView: View {
    
    @Binding var document: Productivity_ProDocument
    @Binding var isPresented: Bool
    
    @State var backgroundColor: String = "white"
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
            .navigationTitle("Add Page")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { addPage() }) {
                        Image(systemName: "doc.badge.plus")
                            .fontWeight(.regular)
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented.toggle() }
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
    
    func addPage() {
        
        let newPage = Page(backgroundColor: backgroundColor,
                           backgroundTemplate: backgroundTemplate,
                           isPortrait: isPortrait
        )
            
        document.document.note.pages.insert(
            newPage, at: toolManager.selectedPage + 1
        )

        isPresented = false
        toolManager.selectedPage += 1
    }
}
