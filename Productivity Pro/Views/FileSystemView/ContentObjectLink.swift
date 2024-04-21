//
//  ContentObjectLink.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.09.23.
//

import SwiftUI

struct ContentObjectLink: View {
    @AppStorage("pp show date") var showDate: Bool = true
    @Bindable var obj: ContentObject
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(Color.accentColor)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(obj.title)
                    .foregroundStyle(Color.primary)
                
                if showDate {
                    Group {
                        Text(obj.created, style: .date) +
                        Text(", ") +
                        Text(obj.created, style: .time)
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                }
            }
            .padding(.leading, 5)
            
            Spacer()
        }
        .frame(height: 40)
    }
    
    var icon: String {
        if obj.type == COType.file.rawValue {
            return "doc.fill"
        } else if obj.type == COType.folder.rawValue {
            return "folder.fill"
        } else if obj.type == COType.vocabulary.rawValue {
            return "laurel.leading"
        } else if obj.type == COType.book.rawValue {
            return "book.closed.fill"
        } else {
            return "questionmark.app.fill"
        }
    }
}
