//
//  PremiumView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI
import Glassfy

struct PremiumView: View {
    @AppStorage("ppisunlocked") var isSubscribed: Bool = false
    
    @Environment(\.horizontalSizeClass) var hsc
    @EnvironmentObject var iapModel: IAPViewModel
    
    @State var type = "com.stoobit.productivity.monthly"
    
    var body: some View {
        VStack {
            Spacer()
            
            ForEach(iapModel.products, id: \.self) { product in
                ProductView(product: product)
            }
            
            Spacer()
            FooterView()
                .padding(30)
        }
        .navigationTitle("Premium")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Wiederherstellen", systemImage: "purchased") {
                    
                }
            }
        }
    }
    
    @ViewBuilder 
    func ProductView(product: Glassfy.Sku) -> some View {
        Button(action: { type = product.product.productIdentifier }) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.ultraThickMaterial)
                
                HStack {
                    VStack {
                        Text("Monatliches Abo")
                            .font(.title3.bold())
                        Spacer()
                    }
                    
                    Spacer()
                    
                    
                }
                .padding(13)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
        }
    }
    
    @ViewBuilder 
    func FooterView() -> some View {
        Button(action: {  }) {
            Text("Premium abonnieren")
                .font(.title3.bold())
                .foregroundStyle(Color.white)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, hsc == .regular ? 60 : 45)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        PremiumView()
            .environmentObject(IAPViewModel())
    }
}
