//
//  DragAnchor.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.05.23.
//

import SwiftUI

struct DragAnchor: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .frame(width: 30, height: 30, alignment: .leading)
            .frame(width: 12, height: 12)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(
                        width: 12,
                        height: 12
                    )
            }
    }
}
