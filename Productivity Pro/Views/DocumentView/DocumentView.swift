//
//  DocumentView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.09.23.
//

import SwiftUI
import SwiftData

struct DocumentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
                
                List {
                    
                }
                .scrollContentBackground(.hidden)
                .environment(\.defaultMinListRowHeight, 30)
            }
        }
    }
}

#Preview {
    DocumentView()
}
