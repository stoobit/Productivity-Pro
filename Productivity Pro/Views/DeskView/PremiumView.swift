//
//  PremiumView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct PremiumView: View {
    @EnvironmentObject var iapModel: IAPViewModel
    
    @AppStorage("ppisunlocked")
    var isSubscribed: Bool = false
    
    var body: some View {
        Text("\(iapModel.products.count)")
    }
}

#Preview {
    PremiumView()
        .environmentObject(IAPViewModel())
}
