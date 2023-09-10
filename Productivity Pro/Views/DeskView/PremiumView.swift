//
//  PremiumView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI
import StoreKit

struct PremiumView: View {
    var body: some View {
        SubscriptionStoreView(
            productIDs: [
                "com.stoobit.pro.premium"
            ]
        )
        .storeButton(.hidden, for: .cancellation)
        .subscriptionStoreControlStyle(.prominentPicker)
        
    }
}

#Preview {
    PremiumView()
}
