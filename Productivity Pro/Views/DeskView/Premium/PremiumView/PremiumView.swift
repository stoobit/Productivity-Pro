//
//  PremiumView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import StoreKit
import SwiftUI

struct PremiumView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var hsc

    @Environment(StoreViewModel.self) var storeVM
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false

    @State var load: Bool = false

    var body: some View {
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
        .storeButton(.visible, for: .restorePurchases)
        .subscriptionStoreControlStyle(.prominentPicker)
        .onInAppPurchaseCompletion { _, result in
            if case .success(.success(_)) = result {
                isSubscribed = true
                dismiss()
            } else {
               print("An error occurred.")
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

#Preview {
    Text("hello")
        .sheet(isPresented: .constant(true), content: {
            PremiumView()
                .environment(StoreViewModel())
        })
}
