//
//  CreateDocToolvar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.09.22.
//

import SwiftUI

struct NewDocumentToolbar: ToolbarContent {
    
    @Binding var selection: String
    
    let size: CGSize
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            
            HStack {
                
                Button(action: {
                    withAnimation {
                        selection = "Note"
                    }
                }) {
                    
                    Label("Note", systemImage: "doc.richtext")
                        .foregroundColor(selection == "Note" ? .accentColor : .gray)
                        .modifier(LabelStyle())
                }
                .frame(width: size.width / 2, alignment: .center)
                
                Button(action: {
                    withAnimation {
                        selection = "Task List"
                    }
                }) {
                    Label("Task List", systemImage: "list.bullet")
                        .foregroundColor(selection == "Task List" ? .accentColor : .gray)
                        .modifier(LabelStyle())
                }
                .frame(width: size.width / 2, alignment: .center)
                
//                Button(action: {
//                    withAnimation {
//                        selection = "Whiteboard"
//                    }
//                }) {
//                    Label("Whiteboard", systemImage: "rectangle.inset.filled")
//                        .foregroundColor(selection == "Whiteboard" ? .accentColor : .gray)
//                        .modifier(LabelStyle())
//                }
//                .padding(.trailing)
//                .padding(.trailing)
//                .frame(width: size.width / 3, alignment: .trailing)
                
            }
            .padding(.bottom)
            
        }
    }
}

struct LabelStyle: ViewModifier {
    
    @Environment(\.horizontalSizeClass) var hsc
    
    func body(content: Content) -> some View {
        if hsc == .regular {
            content
                .labelStyle(.titleAndIcon)
        } else {
            content
        }
    }
}
