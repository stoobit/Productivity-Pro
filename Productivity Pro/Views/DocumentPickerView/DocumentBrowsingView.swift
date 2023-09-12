//
//  DocumentBrowsingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.09.23.
//

import SwiftUI

struct DocumentBrowsingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var url: URL?
    @State var showActionSheet: Bool = false
    
    var body: some View {
        DocumentPickerViewController(url: $url, type: .browse) { dismiss() }
            .ignoresSafeArea(edges: .all)
            .navigationBarBackButtonHidden()
            .onChange(of: url) {
                if url != nil { showActionSheet = true }
                print("change")
            }
            .sheet(isPresented: $showActionSheet) {
                
            }
            
    }
}

#Preview {
    DocumentBrowsingView()
}
