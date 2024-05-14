//
//  DeskPremiumButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.04.24.
//

import StoreKit
import SwiftUI

struct PremiumButton: View {
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    @AppStorage("ppDateOpened") var date: Date = .init()

    let id = "com.stoobit.productivitypro.premium.unlock"

    var body: some View {
        if Date() > Date.freeTrial(date) {
            ProductView(id: id) {
                Image(systemName: "crown.fill")
                    .foregroundStyle(Color.accentColor)
                    .font(.largeTitle)
            }
            .productViewStyle(.compact)
            .onInAppPurchaseCompletion { _, result in
                if case .success(.success) = result {
                    withAnimation(.smooth(duration: 0.2)) {
                        isUnlocked = true
                    }
                }
            }
        } else {
           
        }
    }
}

#Preview {
    PPSettingsView()
}
