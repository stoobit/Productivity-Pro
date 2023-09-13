//
//  DocumentBrowsingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.09.23.
//

import SwiftUI

struct DocumentBrowsingView: View {
    
    @State var url: URL?
    @State var showPicker: Bool = false
    
    var body: some View {
        
        Button(action: {
            showPicker.toggle()
        }) {
            Label("Notizen durchsuchen", systemImage: "magnifyingglass")
                .foregroundStyle(Color.accentColor)
        }
        .fileImporter(
            isPresented: $showPicker,
            allowedContentTypes: [.pro],
            allowsMultipleSelection: false
        ) { result in
            
        }
        
    }
}

#Preview {
    DocumentBrowsingView()
}
