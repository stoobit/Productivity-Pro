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
    @State var error: Bool = false
    
    var body: some View {
        SubscriptionStoreView(
            groupID: "21404124"
        )
        .storeButton(.hidden, for: .cancellation)
        .subscriptionStoreControlStyle(.buttons)
        .background {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
        }
        .onInAppPurchaseCompletion { product, result in
            if case .success(.success) = result {
                isSubscribed = true
            } else {
                error = true
            }
        }
        .alert("Es ist ein Fehler aufgetreten", isPresented: $error, actions: {
            Button("Ok") { error = false }
        }) {
            Text("Die Zahlung konnte aufgrund fehlender Kreditkarteninformationen oder eines anderen Fehlers nicht erfolgreich abgeschlossen werden.")
        }
        
    }
}

#Preview {
    PremiumView()
}
