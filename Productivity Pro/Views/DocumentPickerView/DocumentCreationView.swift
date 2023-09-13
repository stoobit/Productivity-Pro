//
//  DocumentCreationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.09.23.
//

import SwiftUI

struct DocumentCreationView: View {
    
    @State var isDocument: Bool = false
    
    var body: some View {
        
        Button(action: { isDocument.toggle() }) {
            Label("Notiz erstellen", systemImage: "plus")
                .foregroundStyle(Color.accentColor)
        }
        .frame(height: 30)
        .fullScreenCover(isPresented: $isDocument) {
            
        }
        
    }
}

#Preview {
    DocumentCreationView()
}
