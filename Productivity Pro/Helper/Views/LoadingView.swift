//
//  LoadingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 25.10.23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack {
            ProgressView()

            Text("Daten werden verarbeitet...")
                .foregroundStyle(Color.white)
                .padding(.leading)
        }
        .tint(Color.white)
        .padding()
        .progressViewStyle(.circular)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.accentColor)
        }
    }
}
