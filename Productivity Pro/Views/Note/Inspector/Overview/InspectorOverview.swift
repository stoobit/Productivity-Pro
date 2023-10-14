//
//  InspectorOverview.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.10.23.
//

import SwiftUI

struct InspectorOverview: View {
    var body: some View {
        List {
            LazyVStack {
                ForEach(1..<20) { _ in
                    HStack {
                        Image(systemName: "doc")
                            .resizable()
                            .frame(width: 50, height: 70)
                            .clipShape(.rect(cornerRadius: 9))
                        
                        VStack(alignment: .leading, content: {
                            Text("Die Geburt")
                                .font(.title)
                            
                            Text("30. Juli 2007")
                                .font(.caption)
                        })
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, content: {
                            Image(systemName: "bookmark")
                                .imageScale(.large)
                            
                            Spacer()
                            
                            Text("Seite 1")
                                .font(.caption)
                        })
                    }
                    .redacted(reason: .placeholder)
                    .padding(5)
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 10)
        .listStyle(.inset)
    }
}

#Preview {
    InspectorOverview()
}
