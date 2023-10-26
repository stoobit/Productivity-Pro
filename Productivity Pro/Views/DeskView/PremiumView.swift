//
//  PremiumView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI
import StoreKit

struct PremiumView: View {
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    
    var body: some View {
        SubscriptionStoreView(
            groupID: "88811DA5"
        )
        .subscriptionStoreButtonLabel(.multiline)
        .subscriptionStoreControlStyle(.prominentPicker)
        .storeButton(.hidden, for: .cancellation)
        .background {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
        }
        
        
    }
}

#Preview {
    PremiumView()
}
