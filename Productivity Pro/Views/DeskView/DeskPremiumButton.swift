//
//  DeskPremiumButton.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 13.04.24.
//

import StoreKit
import SwiftUI

struct DeskPremiumButton: View {
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    let id = "com.stoobit.productivitypro.premium.unlock"

    var body: some View {
        ProductView(id: id) {
            Image(systemName: "crown.fill")
                .foregroundStyle(Color.accentColor)
                .font(.largeTitle)
        }
        .productViewStyle(.compact)
        .onInAppPurchaseCompletion { _, result in
            if case .success(.success) = result {
                withAnimation {
                    isUnlocked = true
                }
            }
        }
    }
}

#Preview {
    DeskView()
}
