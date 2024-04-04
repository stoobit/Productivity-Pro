//
//  PremiumView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import StoreKit
import SwiftUI

struct PremiumView: View {
    let terms = "https://www.apple.com/legal/internet-services/itunes/dev/stdeula"
    let privacy = "https://www.stoobit.com/privacypolicy.html"

    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var hsc

    @Environment(StoreViewModel.self) var storeVM
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false

    @State var disabled: Bool = false

    var body: some View {
        NavigationStack {
            SubscriptionStoreView(groupID: "21404124") {
                VStack {
                    Text("Premium")
                        .font(.largeTitle.bold())

                    ViewThatFits(in: .vertical) {
                        PVAnimationView()
                        EmptyView()
                    }
                }
            }
            .subscriptionStorePolicyDestination(
                url: URL(string: terms)!, for: .termsOfService
            )
            .subscriptionStorePolicyDestination(
                url: URL(string: privacy)!, for: .privacyPolicy
            )
            .storeButton(.hidden, for: .cancellation)
            .storeButton(.visible, for: .policies)
            .storeButton(.visible, for: .restorePurchases)
            .subscriptionStoreControlStyle(.prominentPicker)
            .onInAppPurchaseCompletion { _, result in
                if case .success(.success(_)) = result {
                    isSubscribed = true
                    dismiss()
                } else {
                    print("An error occurred.")
                }

                disabled = false
            }
            .onInAppPurchaseStart { _ in
                disabled = true
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                    .disabled(disabled)
                }
            }
        }
    }

    let images = [
        "pencil",
        "doc.fill",
        "checklist",
        "eraser.fill",
        "calendar",
        "graduationcap.fill",
        "ruler.fill",
        "paintbrush.fill",
        "highlighter",
        "lasso",
        "tray.full.fill"
    ]
}
