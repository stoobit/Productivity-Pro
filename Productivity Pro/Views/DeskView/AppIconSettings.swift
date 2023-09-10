//
//  AppIconSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct AppIconSettings: View {
    
    @AppStorage("appicon selection") var selection: String = "AppIcon"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("App Icon", selection: $selection) {
                    
                    Icon("RoundedIcon", label: "standard, dunkel")
                        .tag("AppIcon")
                    
                    Icon("RoundedLight", label: "standard, hell")
                        .tag("AppLight")
                    
                    Icon("RoundedBeta", label: "beta, dunkel")
                        .tag("BetaIcon")
                    
                    Icon("RoundedBetaLight", label: "beta, hell")
                        .tag("BetaLight")
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .navigationTitle("App Icon")
        }
        .onChange(of: selection) { old, new in
            UIApplication.shared.setAlternateIconName(new)
        }
    }
    
    @ViewBuilder func Icon(_ image: String, label: String) -> some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 100, height: 100)
            
            Text(label)
            
        }
    }
    
}

#Preview {
    AppIconSettings()
}
