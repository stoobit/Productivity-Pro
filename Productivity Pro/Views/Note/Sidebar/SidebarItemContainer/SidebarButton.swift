//
//  SidebarButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.10.23.
//

import SwiftUI

struct SidebarButton<Content: View>: View {
    
    let action: () -> Void
    let label: () -> Content
    
    var body: some View {
        Button(action: { action() }) {
            label()
                .font(.title3)
                .frame(width: 40, height: 40)
                .background {
                    RoundedRectangle(cornerRadius: 9)
                        .foregroundStyle(.background)
                }
        }
    }
}

#Preview {
    SidebarButton(action: {}) {
        Text("hello")
    }
}
