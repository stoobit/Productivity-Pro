//
//  SidebarColorPicker.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 30.10.23.
//

import SwiftUI

struct SidebarColorPicker: View {
    @State var value: Color = .accentColor
    @Binding var color: Data
    
    var body: some View {
        ColorPicker("", selection: $value)
            .labelsHidden()
            .onChange(of: value, initial: false) {
                color = value.toCodable()
            }
            .onAppear {
                value = Color(codable: color)
            }
            .scaleEffect(0.75)
            .frame(width: 50, height: 50)
            .background {
                RoundedRectangle(cornerRadius: 9)
                    .foregroundStyle(.background)
            }
    }
}
