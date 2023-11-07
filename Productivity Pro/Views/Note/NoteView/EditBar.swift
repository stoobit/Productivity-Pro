//
//  EditBar.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 07.11.23.
//

import SwiftUI

struct EditBar: View {
    @Environment(ToolManager.self) var toolManager
    
    var body: some View {
        
        HStack {
            Group {
                Button(role: .destructive, action: { delete() }) {
                    Image(systemName: "trash")
                }
                
                Button(role: .destructive, action: {}) {
                    Image(systemName: "scissors")
                }
                .padding(.trailing, 5)
                
                Button(action: {}) {
                    Image(systemName: "doc.on.doc.fill")
                }
                
                Button(action: {}) {
                    Image(systemName: "doc.on.doc")
                }
                .padding(.trailing, 5)
            }
            .disabled(toolManager.activeItem == nil)
            
            Button(action: {}) {
                Image(systemName: "doc.on.clipboard")
            }
        }
        .padding(10)
        .imageScale(.large)
        .buttonStyle(.bordered)
        .background {
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 17,
                style: .continuous
            )
            .foregroundStyle(.thinMaterial)
        }
        
    }
    
    func delete() {
        toolManager.activePage?.deleteItem(
            with: toolManager.activeItem?.id
        )
        
        toolManager.activeItem = nil
    }
}

#Preview {
    EditBar()
}
