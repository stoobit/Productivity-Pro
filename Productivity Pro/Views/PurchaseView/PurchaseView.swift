//
//  PurchaseView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.02.26.
//

import SwiftUI
import StoreKit

struct PurchaseView: View {
    @AppStorage("isPurchased") var isPurchased: Bool = false
    var onDismiss: (_ reset: Bool) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 35) {
                VStack(spacing: 20) {
                    Image(systemName: "crown.fill")
                        .foregroundStyle(Color.accentColor)
                        .font(.system(size: 60))
                    
                    Text("Pay once. Use forever.")
                        .multilineTextAlignment(.center)
                        .font(.title.bold())
                }
                
                VStack {
                    HStack {
                        FeatureCard(title: "Tasks", image: "checklist")
                        FeatureCard(title: "Schedule", image: "calendar")
                        FeatureCard(title: "Backups", image: "square.and.arrow.down.on.square")
                    }
                }
                .containerRelativeFrame(.horizontal) { width, _ in
                    return min(350, width)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    ProductView(id: "com.stoobit.productivitypro.premium.unlock")
                        .purchaseButtonStyle()
                        .onInAppPurchaseCompletion(perform: { _, result in
                           onPurchase(with: result)
                        })
                        .containerRelativeFrame(.horizontal) { width, _ in
                            return min(350, width)
                        }
                    
                    Text("This app is crafted by hand. No AI was used in the development.")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                }
                .scenePadding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        onDismiss(true)
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Restore", systemImage: "xmark") {
                        onDismiss(true)
                    }
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
    func onPurchase(with result: Result<Product.PurchaseResult, any Error>) {
        switch result {
        case .success(let success):
            switch success {
            case .success(_):
                isPurchased = true
                onDismiss(false)
            default:
                return
            }
        case .failure(_):
            return
        }
    }
}
