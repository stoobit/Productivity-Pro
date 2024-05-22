//
//  PremiumBadge.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 14.05.24.
//

import SwiftUI

struct PremiumBadge: View {
    @AppStorage("ppisunlocked") var isUnlocked: Bool = false
    @AppStorage("ppDateOpened") var date: Date = .init()

    @State var purchaseView: Bool = false

    var body: some View {
        Group {
            if isUnlocked == false {
                Badge()
            }
        }
        .padding()
        .frame(
            maxWidth: .infinity, maxHeight: .infinity,
            alignment: .bottomTrailing
        )
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $purchaseView, content: {
            PurchaseView {}
        })
    }

    @ViewBuilder func Badge() -> some View {
        Button(action: { purchaseView.toggle() }) {
            Image(systemName: "crown.fill")
                .imageScale(.large)
                .foregroundStyle(Color.white)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color.accentColor)
                }
        }
    }
}

#Preview {
    PremiumBadge().Badge()
}
