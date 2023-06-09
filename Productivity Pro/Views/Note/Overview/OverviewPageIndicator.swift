//
//  OverviewPageIndicator.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 04.06.23.
//

import SwiftUI

struct OverviewPageIndicator: View {
    
    let document: ProductivityProDocument
    
    let index: Int
    let action: () -> Void
    
    var body: some View {
        
        if document.document.note.pages.count != 1 {
            Menu(content: {
                
                Button( role: .destructive, action: action) {
                    Label("Delete Page", systemImage: "trash")
                }
                
            }) {
                Label("\(index + 1)", systemImage: "chevron.down")
                    .foregroundColor(.primary)
            }
            
        } else {
            Text("\(index + 1)")
            .foregroundColor(.primary)
        }
        
    }
}
