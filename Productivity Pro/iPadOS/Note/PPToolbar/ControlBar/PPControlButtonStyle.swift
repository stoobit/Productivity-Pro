//
//  PPControlButtonStyle.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 24.07.23.
//

import SwiftUI

struct PPControlButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .frame(width: 40, height: 40)
            .background(Color.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 9))
    }
}

#Preview {
    Text("Hello, world!")
        .modifier(PPControlButtonStyle())
}
