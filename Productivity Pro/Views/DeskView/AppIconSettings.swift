//
//  AppIconSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct AppIconSettings: View {
    
    @AppStorage("appicon selection") var selection: String = "AppDark"
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("App Icon", selection: $selection) {
                    
                    Icon("RoundedIcon")
                        .tag("AppDark")
                    
                    Icon("RoundedIconLight")
                        .tag("AppLight")
                    
                    Icon("RoundedBeta")
                        .tag("BetaDark")
                    
                    Icon("RoundedBetaLight")
                        .tag("BetaLight")
                    
                    Icon("RoundedMara")
                        .tag("Mara")
                }
                .pickerStyle(.inline)
                .labelsHidden()
            }
            .navigationTitle("App Icon")
        }
        .onChange(of: selection, initial: false) {
            UIApplication.shared.setAlternateIconName(selection)
        }
    }
    
    @ViewBuilder func Icon(_ image: String) -> some View {
        Image(image)
            .resizable()
            .frame(width: 100, height: 100)
    }
    
}

#Preview {
    AppIconSettings()
}
