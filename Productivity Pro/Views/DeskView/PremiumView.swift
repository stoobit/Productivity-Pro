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
            groupID: "BE768D4B"
        )
        .storeButton(.hidden, for: .cancellation)
        .subscriptionStoreControlStyle(.prominentPicker)
        
    }
}

#Preview {
    PremiumView()
}
