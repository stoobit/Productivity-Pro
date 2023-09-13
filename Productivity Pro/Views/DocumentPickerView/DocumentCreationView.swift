//
//  DocumentCreationView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.09.23.
//

import SwiftUI

struct DocumentCreationView: View {
    var body: some View {
        
        Button(action: {  }) {
            Label("Notiz erstellen", systemImage: "plus")
                .foregroundStyle(Color.accentColor)
        }
        .frame(height: 30)
        
    }
}

#Preview {
    DocumentCreationView()
}
