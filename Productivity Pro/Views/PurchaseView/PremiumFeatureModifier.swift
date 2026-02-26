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
    
    @AppStorage("isPurchased")
    private var isPurchased: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: premiumCheck)
            .sheet(isPresented: $isPresented) {
                PurchaseView { reset in
                    Task { @MainActor in
                        isPresented = false
                        
                        if reset {
                            try await Task.sleep(for: .seconds(0.1))
                            selectedTab = .notes
                        }
                    }
                }
            }
    }
    
    private func premiumCheck() {
        if isPurchased == false {
            Task { @MainActor in
                try await Task.sleep(for: .seconds(0.15))
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
