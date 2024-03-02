//
//  File.swift
//  
//
//  Created by Till Brügmann on 05.11.23.
//

import SwiftUI

@available(iOS 17.0, *)
@available(macOS 14.0, *)
struct DKButton: View {
    
    var title: String
    var position: Alignment
    
    let action: () ->Void
    
    var body: some View {
        Button(action: { action() }) {
            Group {
                if title == "delete.left.fill" {
                    Image(systemName: title)
                        .imageScale(.large)
                } else {
                    Text(title)
                        .font(.title3.bold())
                }
            }
            .foregroundStyle(Color.white)
            .frame(width: 60, height: 40)
            .background(
                title == "delete.left.fill" || title == "." ? Color.gray : Color.accentColor
            )
            .clipShape(
                .rect(
                    topLeadingRadius: 6,
                    bottomLeadingRadius: position == .bottomLeading ? 12 : 6,
                    bottomTrailingRadius: position == .bottomTrailing ? 12 : 6,
                    topTrailingRadius: 6,
                    style: .continuous
                )
            )
        }
        .modifier(PPShortcutModifier(shortcut: title))
    }
}
