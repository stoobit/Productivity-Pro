//
//  PVOfferView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 05.12.23.
//

import SwiftUI

extension PremiumView {
    @ViewBuilder func PVOfferView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
           HStack {
               ViewThatFits(in: .horizontal) {
                   Text("Productivity Pro Premium")
                   Text("Premium")
               }
               
               Spacer()
               Text("2.99€ / Monat")
                   .foregroundStyle(Color.accentColor.gradient)
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
