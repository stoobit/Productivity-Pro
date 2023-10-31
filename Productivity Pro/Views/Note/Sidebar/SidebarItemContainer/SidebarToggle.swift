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
                .foregroundStyle(isOn ? .white : .primary)
                .font(.title3)
                .frame(width: 40, height: 40)
                .background {
                    Group {
                        if isOn {
                            RoundedRectangle(cornerRadius: 9)
                                .foregroundStyle(Color.accentColor)
                        } else {
                            RoundedRectangle(cornerRadius: 9)
                                .foregroundStyle(.background)
                        }
                    }
                    .animation(.bouncy, value: isOn)
                }
        }
    }
}
