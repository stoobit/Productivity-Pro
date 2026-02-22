//
//  PremiumFeatureModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.02.26.
//

import SwiftUI

struct PremiumFeatureModifier: ViewModifier {
    @Binding var selectedTab: TabType
    @State private var isPresented: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: premiumCheck)
            .sheet(isPresented: $isPresented) {
                PurchaseView {
                    Task { @MainActor in
                        isPresented = false
                        try await Task.sleep(for: .seconds(0.1))
                        selectedTab = .notes
                    }
                }
            }
    }
    
    private func premiumCheck() {
        if true { // TODO: perform premium check
            Task { @MainActor in
                try await Task.sleep(for: .seconds(0.1))
                isPresented = true
            }
        }
    }
}

extension View {
    @ViewBuilder func premiumFeature(tab: Binding<TabType>) -> some View {
        modifier(PremiumFeatureModifier(selectedTab: tab))
    }
}
