//
//  LibraryView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        NavigationStack {
            
            VStack {
                Image(systemName: "books.vertical.fill")
                    .font(.system(size: 100))
                
                Text("Noch sind keine Bücher verfügbar.")
                    .font(.title.bold())
                    .padding(.top)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(.blue.secondary)
            
        }
    }
}

#Preview {
    LibraryView()
}
