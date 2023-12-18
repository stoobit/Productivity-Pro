//
//  DragAnchor.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.05.23.
//

import SwiftUI

struct DragAnchor: View {
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: 12, height: 12)

            Circle()
                .foregroundColor(color)
                .frame(width: 8, height: 8)
        }
        .frame(width: 50, height: 50)
        .contentShape(Circle())
    }
}
