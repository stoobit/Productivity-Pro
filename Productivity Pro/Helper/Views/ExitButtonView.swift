//
//  ExitButtonView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.07.23.
//

import SwiftUI

struct ExitButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Circle()
            .fill(Color(.secondarySystemBackground))
            .frame(width: 30, height: 30)
            .overlay(
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(.secondary)
            )
    }
}
