//
//  OnboardingView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.02.24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            TabView {
                IntroView()
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Überspringen") { dismiss() }
                }
            }
        }
    }

    @ViewBuilder func IntroView() -> some View {}
}

#Preview {
    OnboardingView()
}
