//
//  AIProgressView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.04.24.
//

import SwiftUI

struct AIProgressView: View {
    var body: some View {
        HStack {
            ProgressView(value: 33, total: 100)
                .tint(Color.primary)
                .progressViewStyle(.linear)

            Text("33%")
                .padding(.leading)
        }
        .padding(50)
    }
}

#Preview {
    AIProgressView()
}
