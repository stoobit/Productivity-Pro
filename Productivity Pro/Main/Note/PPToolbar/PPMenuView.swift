//
//  PPMenuView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.07.23.
//

import SwiftUI

struct PPMenuView: View {
    
    @StateObject var toolManager: ToolManager
    
    var body: some View {
        Menu(content: {
            
            Button(action: { toolManager.isLocked.toggle() }) {
                Toggle(isOn: $toolManager.isLocked, label: {
                    Label("Scrolling Disabled", systemImage: "hand.draw")
                })
            }
            
            Section("Editing") {
                Button(role: .destructive, action: {  }) {
                    Label("Delete", systemImage: "delete.left")
                }
                
                Button(role: .destructive, action: {  }) {
                    Label("Cut", systemImage: "scissors")
                }
                
                Button(action: {  }) {
                    Label("Duplicate", systemImage: "doc.on.doc.fill")
                }
                
                Button(action: {  }) {
                    Label("Paste", systemImage: "doc.on.clipboard")
                }
                
                Button(action: {  }) {
                    Label("Copy", systemImage: "doc.on.doc")
                }
            }
            
        }) {
            
            Image(systemName: "ellipsis")
                .foregroundStyle(Color.accentColor)
                .font(.title3)
                .frame(width: 40, height: 40)
                .background(Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 9))
            
        }
        
        
    }
}
