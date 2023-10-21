//
//  ContentObjectLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI

struct ContentObjectLink: View {
    
    @Bindable var obj: ContentObject
    
    var body: some View {
        HStack {
            Image(
                systemName: obj.type == COType.file.rawValue ? "doc.fill" : "folder.fill"
            )
            .font(.title)
            .foregroundStyle(Color.accentColor)
            .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(obj.title)
                    .foregroundStyle(Color.primary)
                
                Group {
                    Text(obj.created, style: .date) +
                    Text(", ") +
                    Text(obj.created, style: .time)
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
            }
            .padding(.leading, 5)
            
            Spacer()
        }
        .frame(height: 40)
    }
}
