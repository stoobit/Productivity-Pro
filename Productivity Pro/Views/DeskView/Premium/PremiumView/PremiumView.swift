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
    @AppStorage("ppisstoobitdeveloper") var isDeveloper: Bool = false

    @State var load: Bool = false
    @State var disabled: Bool = false
    @State var showAlert: Bool = false
    @State var text: String = ""

    var body: some View {
        NavigationStack {
            SubscriptionStoreView(productIDs: storeVM.productIds) {
                VStack {
                    Text("Premium")
                        .font(.largeTitle.bold())

                    ViewThatFits(in: .vertical) {
                        PVAnimationView()
                        Color.clear.frame(width: 0, height: 0)
                    }
                }
            }
            .subscriptionStorePolicyDestination(
                url: URL(string: terms)!,for: .termsOfService
            )
            .subscriptionStorePolicyDestination(
                url: URL(string: privacy)!,for: .privacyPolicy
            )
            .storeButton(.visible, for: .policies)
            .storeButton(.hidden, for: .cancellation)
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

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Entwickler", systemImage: "person.fill") {
                        showAlert.toggle()
                    }
                    .disabled(disabled)
                }
            }
        }
        .alert("Productivity Pro", isPresented: $showAlert) {
            Button("Abbrechen", role: .cancel) {
                showAlert = false
                text = ""
            }

            Button("Anmelden") {
                if text == "xAbu-RTi-093-mMkl-öÜ" {
                    isDeveloper = true
                    isSubscribed = true
                }

                showAlert = false
                dismiss()
            }

            SecureField("Passwort", text: $text)
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
