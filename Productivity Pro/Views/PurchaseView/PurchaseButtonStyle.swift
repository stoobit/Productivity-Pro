//
//  PurchaseButtonStyle.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 26.02.26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func purchaseButtonStyle() -> some View {
        modifier(PurchaseButtonModifier())
    }
}

fileprivate struct PurchaseButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .productDescription(.hidden)
            .productViewStyle(.large)
            .buttonSizing(.flexible)
            .buttonBorderShape(.capsule)
            .buttonStyle(PurchaseButtonStyle())
    }
}

fileprivate struct PurchaseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 47)
            .glassEffect(.regular.tint(Color.accent).interactive(), in: .capsule)
    }
}
