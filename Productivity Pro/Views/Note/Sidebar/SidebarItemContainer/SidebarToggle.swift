//
//  SidebarToggle.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.10.23.
//

import SwiftUI

struct SidebarToggle<Content: View>: View {
    @Binding var isOn: Bool
    
    let label: () -> Content
    
    var body: some View {
        Button(action: { isOn.toggle() }) {
            label()
                .foregroundStyle(isOn ? Color.accentColor : .secondary)
                .font(.title3)
                .frame(width: 40, height: 40)
                .background {
                    RoundedRectangle(cornerRadius: 9)
                        .foregroundStyle(.background)
                }
        }
    }
}
