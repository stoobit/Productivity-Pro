//
//  PVOfferView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.12.23.
//

import SwiftUI
import StoreKit

extension PremiumView {
    @ViewBuilder func PVOfferView(product: Product) -> some View {
        VStack(alignment: .leading, spacing: 10) {
           HStack {
               ViewThatFits(in: .horizontal) {
                   Text("Productivity Pro Premium")
                   Text("Premium")
               }
               
               Spacer()
               Text("\(product.displayPrice) / Jahr")
                   .foregroundStyle(Color.accentColor)
           }
           .font(.title3.bold())
               
           Text("•  Stundenplan")
           Text("•  Aufgaben")
           Text("•  App Icons")
       }
       .padding()
       .background {
           RoundedRectangle(cornerRadius: 15)
               .foregroundStyle(.ultraThinMaterial)
           
           RoundedRectangle(cornerRadius: 15)
               .stroke(Color.accentColor.gradient, lineWidth: 2.0)
       }
       .padding(.horizontal)
    }
}
